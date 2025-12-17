import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import Navbar from './components/Navbar';
import PrivateRoute from './components/PrivateRoute';
import Login from './pages/Login';
import Register from './pages/Register';
import Dashboard from './pages/Dashboard';
import FacultyList from './pages/FacultyList';
import AddFaculty from './pages/AddFaculty';
import FacultyDetail from './pages/FacultyDetail';
import './App.css';

function App() {
  return (
    <AuthProvider>
      <Router>
        <div className="App">
          <Navbar />
          <Routes>
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/dashboard" element={
              <PrivateRoute>
                <Dashboard />
              </PrivateRoute>
            } />
            <Route path="/faculty" element={
              <PrivateRoute>
                <FacultyList />
              </PrivateRoute>
            } />
            <Route path="/add-faculty" element={
              <PrivateRoute>
                <AddFaculty />
              </PrivateRoute>
            } />
            <Route path="/faculty/:id" element={
              <PrivateRoute>
                <FacultyDetail />
              </PrivateRoute>
            } />
            <Route path="/" element={<Navigate to="/login" />} />
          </Routes>
        </div>
      </Router>
    </AuthProvider>
  );
}

export default App;
