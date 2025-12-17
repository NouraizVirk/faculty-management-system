const express = require('express');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { pool, initDB } = require('./db');
const authMiddleware = require('./middleware/auth');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// AUTH ROUTES

// Register
app.post('/api/auth/register', async (req, res) => {
  const { username, email, password } = req.body;
  
  if (!username || !email || !password) {
    return res.status(400).json({ error: 'All fields are required' });
  }
  
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const result = await pool.query(
      'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING id, username, email',
      [username, email, hashedPassword]
    );
    
    const token = jwt.sign(
      { id: result.rows[0].id, username: result.rows[0].username },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );
    
    res.status(201).json({ 
      user: result.rows[0],
      token 
    });
  } catch (error) {
    if (error.code === '23505') {
      res.status(400).json({ error: 'Username or email already exists' });
    } else {
      console.error('Error registering user:', error);
      res.status(500).json({ error: 'Failed to register user' });
    }
  }
});

// Login
app.post('/api/auth/login', async (req, res) => {
  const { username, password } = req.body;
  
  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required' });
  }
  
  try {
    const result = await pool.query('SELECT * FROM users WHERE username = $1', [username]);
    
    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    const user = result.rows[0];
    const validPassword = await bcrypt.compare(password, user.password);
    
    if (!validPassword) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    const token = jwt.sign(
      { id: user.id, username: user.username },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );
    
    res.json({ 
      user: { id: user.id, username: user.username, email: user.email },
      token 
    });
  } catch (error) {
    console.error('Error logging in:', error);
    res.status(500).json({ error: 'Failed to login' });
  }
});

// FACULTY ROUTES (Protected)

// GET all faculty
app.get('/api/faculty', authMiddleware, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM faculty ORDER BY created_at DESC');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching faculty:', error);
    res.status(500).json({ error: 'Failed to fetch faculty' });
  }
});

// GET single faculty
app.get('/api/faculty/:id', authMiddleware, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM faculty WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Faculty not found' });
    }
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching faculty:', error);
    res.status(500).json({ error: 'Failed to fetch faculty' });
  }
});

// POST new faculty
app.post('/api/faculty', authMiddleware, async (req, res) => {
  const { name, department, email, phone } = req.body;
  
  if (!name || !department || !email) {
    return res.status(400).json({ error: 'Name, department, and email are required' });
  }
  
  try {
    const result = await pool.query(
      'INSERT INTO faculty (name, department, email, phone) VALUES ($1, $2, $3, $4) RETURNING *',
      [name, department, email, phone || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    if (error.code === '23505') {
      res.status(400).json({ error: 'Email already exists' });
    } else {
      console.error('Error adding faculty:', error);
      res.status(500).json({ error: 'Failed to add faculty' });
    }
  }
});

// PUT update faculty
app.put('/api/faculty/:id', authMiddleware, async (req, res) => {
  const { name, department, email, phone } = req.body;
  
  try {
    const result = await pool.query(
      'UPDATE faculty SET name = $1, department = $2, email = $3, phone = $4 WHERE id = $5 RETURNING *',
      [name, department, email, phone, req.params.id]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Faculty not found' });
    }
    
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error updating faculty:', error);
    res.status(500).json({ error: 'Failed to update faculty' });
  }
});

// DELETE faculty
app.delete('/api/faculty/:id', authMiddleware, async (req, res) => {
  try {
    const result = await pool.query('DELETE FROM faculty WHERE id = $1 RETURNING *', [req.params.id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Faculty not found' });
    }
    
    res.json({ message: 'Faculty deleted successfully' });
  } catch (error) {
    console.error('Error deleting faculty:', error);
    res.status(500).json({ error: 'Failed to delete faculty' });
  }
});

// DASHBOARD STATS
app.get('/api/stats', authMiddleware, async (req, res) => {
  try {
    const facultyCount = await pool.query('SELECT COUNT(*) FROM faculty');
    const deptCount = await pool.query('SELECT COUNT(DISTINCT department) FROM faculty');
    const recentFaculty = await pool.query('SELECT * FROM faculty ORDER BY created_at DESC LIMIT 5');
    
    res.json({
      totalFaculty: parseInt(facultyCount.rows[0].count),
      totalDepartments: parseInt(deptCount.rows[0].count),
      recentFaculty: recentFaculty.rows
    });
  } catch (error) {
    console.error('Error fetching stats:', error);
    res.status(500).json({ error: 'Failed to fetch stats' });
  }
});

// Initialize database and start server
initDB().then(() => {
  app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
  });
});
