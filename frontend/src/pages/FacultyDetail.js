import React, { useState, useEffect, useCallback } from 'react';
import { useAuth } from '../context/AuthContext';
import { useNavigate, useParams } from 'react-router-dom';
import './FacultyDetail.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000/api';

const FacultyDetail = () => {
  const { token } = useAuth();
  const navigate = useNavigate();
  const { id } = useParams();
  const [faculty, setFaculty] = useState(null);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(false);
  const [formData, setFormData] = useState({});
  const [message, setMessage] = useState('');

  const fetchFaculty = useCallback(async () => {
    try {
      const response = await fetch(`${API_URL}/faculty/${id}`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (response.ok) {
        const data = await response.json();
        setFaculty(data);
        setFormData(data);
      } else {
        navigate('/faculty');
      }
    } catch (error) {
      console.error('Error fetching faculty:', error);
    } finally {
      setLoading(false);
    }
  }, [id, token, navigate]);

  useEffect(() => {
    fetchFaculty();
  }, [fetchFaculty]);

  const handleUpdate = async (e) => {
    e.preventDefault();
    
    try {
      const response = await fetch(`${API_URL}/faculty/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(formData),
      });

      if (response.ok) {
        const data = await response.json();
        setFaculty(data);
        setEditing(false);
        setMessage('Faculty updated successfully!');
        setTimeout(() => setMessage(''), 3000);
      }
    } catch (error) {
      console.error('Error updating faculty:', error);
    }
  };

  if (loading) {
    return <div className="loading">Loading faculty details...</div>;
  }

  if (!faculty) {
    return <div className="loading">Faculty not found</div>;
  }

  return (
    <div className="faculty-detail-page">
      <div className="detail-container">
        <div className="detail-header">
          <h1>Faculty Details</h1>
          <button onClick={() => navigate('/faculty')} className="btn-back">← Back to List</button>
        </div>

        {message && <div className="success-message">{message}</div>}

        {!editing ? (
          <div className="detail-view">
            <div className="detail-item">
              <label>ID:</label>
              <span>{faculty.id}</span>
            </div>
            <div className="detail-item">
              <label>Name:</label>
              <span>{faculty.name}</span>
            </div>
            <div className="detail-item">
              <label>Department:</label>
              <span>{faculty.department}</span>
            </div>
            <div className="detail-item">
              <label>Email:</label>
              <span>{faculty.email}</span>
            </div>
            <div className="detail-item">
              <label>Phone:</label>
              <span>{faculty.phone || 'N/A'}</span>
            </div>
            <div className="detail-item">
              <label>Created At:</label>
              <span>{new Date(faculty.created_at).toLocaleString()}</span>
            </div>
            <button onClick={() => setEditing(true)} className="btn-edit">Edit Faculty</button>
          </div>
        ) : (
          <form onSubmit={handleUpdate} className="edit-form">
            <div className="form-group">
              <label>Name:</label>
              <input
                type="text"
                value={formData.name}
                onChange={(e) => setFormData({...formData, name: e.target.value})}
                required
              />
            </div>
            <div className="form-group">
              <label>Department:</label>
              <input
                type="text"
                value={formData.department}
                onChange={(e) => setFormData({...formData, department: e.target.value})}
                required
              />
            </div>
            <div className="form-group">
              <label>Email:</label>
              <input
                type="email"
                value={formData.email}
                onChange={(e) => setFormData({...formData, email: e.target.value})}
                required
              />
            </div>
            <div className="form-group">
              <label>Phone:</label>
              <input
                type="tel"
                value={formData.phone || ''}
                onChange={(e) => setFormData({...formData, phone: e.target.value})}
              />
            </div>
            <div className="form-actions">
              <button type="submit" className="btn-save">Save Changes</button>
              <button type="button" onClick={() => setEditing(false)} className="btn-cancel">Cancel</button>
            </div>
          </form>
        )}
      </div>
    </div>
  );
};

export default FacultyDetail;
