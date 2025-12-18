import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';
import { useNavigate } from 'react-router-dom';
import './FacultyList.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000/api';

const FacultyList = () => {
  const { token } = useAuth();
  const navigate = useNavigate();
  const [faculty, setFaculty] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');

  useEffect(() => {
    fetchFaculty();
  }, []);

  const fetchFaculty = async () => {
    try {
      const response = await fetch(`${API_URL}/faculty`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (response.ok) {
        const data = await response.json();
        setFaculty(data);
      }
    } catch (error) {
      console.error('Error fetching faculty:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (window.confirm('Are you sure you want to delete this faculty member?')) {
      try {
        const response = await fetch(`${API_URL}/faculty/${id}`, {
          method: 'DELETE',
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });
        
        if (response.ok) {
          fetchFaculty();
        }
      } catch (error) {
        console.error('Error deleting faculty:', error);
      }
    }
  };

  const filteredFaculty = faculty.filter(f => 
    f.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    f.department.toLowerCase().includes(searchTerm.toLowerCase()) ||
    f.email.toLowerCase().includes(searchTerm.toLowerCase())
  );

  if (loading) {
    return <div className="loading">Loading faculty list...</div>;
  }

  return (
    <div className="faculty-list-page">
      <div className="page-header">
        <h1>Faculty List</h1>
        <button onClick={() => navigate('/add-faculty')} className="btn-add">+ Add Faculty</button>
      </div>

      <div className="search-box">
        <input
          type="text"
          placeholder="Search by name, department, or email..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="search-input"
        />
      </div>

      {filteredFaculty.length === 0 ? (
        <div className="no-data">
          {searchTerm ? 'No faculty members match your search.' : 'No faculty members found.'}
        </div>
      ) : (
        <div className="faculty-table-container">
          <table className="faculty-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Department</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {filteredFaculty.map((member) => (
                <tr key={member.id}>
                  <td>{member.id}</td>
                  <td>{member.name}</td>
                  <td>{member.department}</td>
                  <td>{member.email}</td>
                  <td>{member.phone || 'N/A'}</td>
                  <td className="actions">
                    <button onClick={() => navigate(`/faculty/${member.id}`)} className="btn-view-small">View</button>
                    <button onClick={() => handleDelete(member.id)} className="btn-delete">Delete</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default FacultyList;
