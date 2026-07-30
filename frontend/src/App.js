import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [stats, setStats] = useState({ totalFaculty: 12, totalDepartments: 4 });
  const [faculty, setFaculty] = useState([
    { id: 1, name: 'Dr. Sarah Connor', department: 'Computer Science', email: 's.connor@university.edu', phone: '+1 555-0192' },
    { id: 2, name: 'Prof. Alan Turing', department: 'Mathematics', email: 'a.turing@university.edu', phone: '+1 555-0193' },
    { id: 3, name: 'Dr. Grace Hopper', department: 'Software Engineering', email: 'g.hopper@university.edu', phone: '+1 555-0194' }
  ]);

  return (
    <div className="app-container">
      <header className="app-header">
        <h1>🎓 Faculty Management System</h1>
        <span className="badge">DevOps Enabled</span>
      </header>

      <main className="app-main">
        <section className="stats-grid">
          <div className="stat-card">
            <h3>Total Faculty</h3>
            <p className="stat-number">{stats.totalFaculty}</p>
          </div>
          <div className="stat-card">
            <h3>Departments</h3>
            <p className="stat-number">{stats.totalDepartments}</p>
          </div>
          <div className="stat-card">
            <h3>System Status</h3>
            <p className="stat-status">🟢 Operational</p>
          </div>
        </section>

        <section className="faculty-section">
          <h2>Faculty Directory</h2>
          <table className="faculty-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Department</th>
                <th>Email</th>
                <th>Phone</th>
              </tr>
            </thead>
            <tbody>
              {faculty.map((item) => (
                <tr key={item.id}>
                  <td>#{item.id}</td>
                  <td><strong>{item.name}</strong></td>
                  <td><span className="dept-tag">{item.department}</span></td>
                  <td>{item.email}</td>
                  <td>{item.phone}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </section>
      </main>
    </div>
  );
}

export default App;
