#!/bin/bash

# ============================================
# Faculty Management System - Deployment Status
# ============================================

echo "============================================"
echo "FACULTY MANAGEMENT SYSTEM - DEPLOYMENT STATUS"
echo "============================================"
echo ""

# ============================================
# 1. GET PODS
# ============================================
echo "1. KUBERNETES PODS STATUS"
echo "Command: kubectl get pods -n faculty-management"
echo "--------------------------------------------"
kubectl get pods -n faculty-management
echo ""

# ============================================
# 2. GET SERVICES
# ============================================
echo "2. KUBERNETES SERVICES"
echo "Command: kubectl get svc -n faculty-management"
echo "--------------------------------------------"
kubectl get svc -n faculty-management
echo ""

# ============================================
# 3. GET ALL RESOURCES
# ============================================
echo "3. ALL KUBERNETES RESOURCES"
echo "Command: kubectl get all -n faculty-management"
echo "--------------------------------------------"
kubectl get all -n faculty-management
echo ""

# ============================================
# 4. GET DEPLOYMENTS
# ============================================
echo "4. DEPLOYMENTS STATUS"
echo "Command: kubectl get deployments -n faculty-management"
echo "--------------------------------------------"
kubectl get deployments -n faculty-management
echo ""

# ============================================
# 5. GET EXTERNAL IP
# ============================================
echo "5. APPLICATION URL"
echo "--------------------------------------------"
EXTERNAL_IP=$(kubectl get svc faculty-frontend -n faculty-management -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
if [ -n "$EXTERNAL_IP" ]; then
    echo "✅ Application URL: http://$EXTERNAL_IP"
    echo ""
    echo "Open this URL in your browser to access the application"
else
    echo "⚠️  External IP not found or still pending"
fi
echo ""

# ============================================
# 6. POD DETAILS
# ============================================
echo "6. DETAILED POD INFORMATION"
echo "Command: kubectl describe pods -n faculty-management"
echo "--------------------------------------------"
kubectl describe pods -n faculty-management
echo ""

# ============================================
# 7. RECENT LOGS
# ============================================
echo "7. RECENT APPLICATION LOGS"
echo "--------------------------------------------"

echo "Frontend Logs (last 10 lines):"
kubectl logs -n faculty-management -l app=faculty-frontend --tail=10
echo ""

echo "Backend Logs (last 10 lines):"
kubectl logs -n faculty-management -l app=faculty-backend --tail=10
echo ""

echo "Database Logs (last 10 lines):"
kubectl logs -n faculty-management -l app=postgres --tail=10
echo ""

# ============================================
# 8. SUMMARY
# ============================================
echo "============================================"
echo "DEPLOYMENT SUMMARY"
echo "============================================"

TOTAL_PODS=$(kubectl get pods -n faculty-management --no-headers | wc -l)
RUNNING_PODS=$(kubectl get pods -n faculty-management --no-headers | grep Running | wc -l)

echo "Total Pods: $TOTAL_PODS"
echo "Running Pods: $RUNNING_PODS"
echo ""

if [ "$RUNNING_PODS" -eq "$TOTAL_PODS" ]; then
    echo "✅ All pods are running successfully!"
else
    echo "⚠️  Some pods are not running"
fi

echo ""
echo "Application URL: http://$EXTERNAL_IP"
echo ""
echo "============================================"
echo "SCREENSHOTS READY!"
echo "Take screenshots of the output above for your submission"
echo "============================================"
