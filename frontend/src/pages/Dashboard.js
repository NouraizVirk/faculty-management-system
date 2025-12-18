import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';
import { useNavigate } from 'react-router-dom';
import './Dashboard.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000/api';

const Dashboard = () => {
  const { token } = useAuth();
  const navigate = useNavigate();
  const [stats, setStats] = useState({
    totalFaculty: 0,
    totalDepartments: 0,
    recentFaculty: []
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchStats();
  }, []);

  const fetchStats = async () => {
    try {
      const response = await fetch(`${API_URL}/stats`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (response.ok) {
        const data = await response.json();
        setStats(data);
      }
    } catch (error) {
      console.error('Error fetching stats:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <div className="loading">Loading dashboard...</div>;
  }

  return (
    <div className="dashboard">
      <h1>Dashboard</h1>
      
      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-icon">👥</div>
          <div className="stat-info">
            <h3>{stats.totalFaculty}</h3>
            <p>Total Faculty</p>
          </div>
        </div>
        
        <div className="stat-card">
          <div className="stat-icon">🏢</div>
          <div className="stat-info">
            <h3>{stats.totalDepartments}</h3>
            <p>Departments</p>
          </div>
        </div>
      </div>

      <div className="recent-section">
        <h2>Recent Faculty Members</h2>
        {stats.recentFaculty.length === 0 ? (
          <p className="no-data">No faculty members yet. <button onClick={() => navigate('/add-faculty')} className="link-btn">Add one now</button></p>
        ) : (
          <div className="recent-list">
            {stats.recentFaculty.map((faculty) => (
              <div key={faculty.id} className="recent-item">
                <div className="recent-info">
                  <h4>{faculty.name}</h4>
                  <p>{faculty.department}</p>
                  <p className="email">{faculty.email}</p>
                </div>
                <button onClick={() => navigate(`/faculty/${faculty.id}`)} className="btn-view">View</button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default Dashboard;
