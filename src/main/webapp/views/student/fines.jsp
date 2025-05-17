<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 5/17/2025
  Time: 8:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Fines - LibraryMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6C63FF;
            --secondary-color: #4A41D7;
            --dark-color: #2A2F4F;
            --light-color: #F7F7FC;
            --success-color: #10B981;
            --error-color: #EF4444;
            --warning-color: #F59E0B;
            --accent-color: #FF6C63;
            --sidebar-width: 260px;
            --header-height: 70px;
            --shadow-sm: 0 2px 10px rgba(108, 99, 255, 0.1);
            --shadow-md: 0 4px 20px rgba(108, 99, 255, 0.15);
            --shadow-lg: 0 10px 40px rgba(108, 99, 255, 0.2);
            --border-radius: 16px;
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            --gradient-bg: linear-gradient(135deg, #6C63FF 0%, #4A41D7 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
        }

        body {
            background-color: var(--light-color);
            color: var(--dark-color);
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: white;
            box-shadow: var(--shadow-md);
            padding: 2rem 1.5rem;
            overflow-y: auto;
            z-index: 100;
            transition: var(--transition);
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            padding-bottom: 1.8rem;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            margin-bottom: 1.8rem;
        }

        .sidebar-logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 0.7rem;
            text-decoration: none;
            transition: var(--transition);
        }

        .sidebar-logo:hover {
            transform: translateY(-2px);
        }

        .nav-items {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            flex-grow: 1;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--dark-color);
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            gap: 1rem;
            font-weight: 500;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(108, 99, 255, 0.08);
            color: var(--primary-color);
            transform: translateX(5px);
        }

        .nav-link.active {
            background: var(--primary-color);
            color: white;
            box-shadow: var(--shadow-sm);
        }

        .nav-link i {
            width: 22px;
            font-size: 1.1rem;
        }

        .logout-section {
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.05);
            margin-top: 2rem;
        }

        .logout-link {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--error-color);
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            gap: 1rem;
            font-weight: 600;
        }

        .logout-link:hover {
            background: rgba(239, 68, 68, 0.08);
            transform: translateX(5px);
        }

        .logout-link i {
            width: 22px;
            font-size: 1.1rem;
        }

        /* Header styles */
        .header {
            position: fixed;
            top: 0;
            left: var(--sidebar-width);
            right: 0;
            height: var(--header-height);
            background: white;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2.5rem;
            z-index: 99;
        }

        .header-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .header-title i {
            color: var(--primary-color);
            font-size: 1.3rem;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.7rem 1.5rem;
            background: var(--error-color);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            font-weight: 600;
            box-shadow: 0 2px 10px rgba(239, 68, 68, 0.2);
        }

        .logout-btn:hover {
            background: #D22B2B;
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(239, 68, 68, 0.3);
        }

        .mobile-menu-toggle {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 50px;
            height: 50px;
            background: var(--gradient-bg);
            border-radius: 50%;
            display: none;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            cursor: pointer;
            z-index: 999;
            box-shadow: var(--shadow-md);
        }

        /* Main content */
        .main-content {
            margin-left: var(--sidebar-width);
            margin-top: var(--header-height);
            padding: 2.5rem;
            min-height: calc(100vh - var(--header-height));
            background: var(--light-color);
        }

        .welcome-message {
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 2.5rem;
            position: relative;
            display: inline-block;
        }

        .welcome-message::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 4px;
            background: var(--primary-color);
            bottom: -10px;
            left: 0;
            border-radius: 2px;
        }

        /* Fine Summary Card */
        .fine-summary {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            margin-bottom: 2.5rem;
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .fine-summary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--error-color);
            border-radius: var(--border-radius) 0 0 var(--border-radius);
        }

        .fine-total {
            flex: 1;
            min-width: 250px;
        }

        .fine-label {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 0.8rem;
            font-weight: 500;
        }

        .fine-amount {
            font-size: 2.8rem;
            font-weight: 800;
            color: var(--error-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .fine-currency {
            font-weight: 600;
            font-size: 1.8rem;
        }

        .fine-details {
            flex: 1.5;
            min-width: 300px;
        }

        .fine-status {
            display: flex;
            gap: 2rem;
            margin-bottom: 1.2rem;
        }

        .status-item {
            display: flex;
            flex-direction: column;
        }

        .status-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
        }

        .status-label {
            font-size: 0.9rem;
            color: #666;
        }

        .fine-actions {
            padding-top: 1.2rem;
        }

        .pay-all-btn {
            padding: 1rem 2rem;
            background: var(--error-color);
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
        }

        .pay-all-btn:hover {
            background: #D22B2B;
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }

        .fine-methods {
            margin-top: 1.5rem;
        }

        .method-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.8rem;
        }

        .payment-methods {
            display: flex;
            gap: 1rem;
        }

        .payment-method {
            padding: 0.6rem 1.2rem;
            background: white;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--dark-color);
            cursor: pointer;
            transition: var(--transition);
        }

        .payment-method.active {
            background: rgba(108, 99, 255, 0.1);
            border-color: var(--primary-color);
            color: var(--primary-color);
        }

        .payment-method:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
        }

        /* Tabs */
        .tabs {
            display: flex;
            margin-bottom: 2rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .tab {
            padding: 1rem 2rem;
            font-weight: 600;
            color: #666;
            cursor: pointer;
            transition: var(--transition);
            position: relative;
        }

        .tab.active {
            color: var(--primary-color);
        }

        .tab.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px 3px 0 0;
        }

        .tab:hover {
            color: var(--primary-color);
        }

        /* Tab Content */
        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Fine Table */
        .fine-table-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            padding: 1.5rem;
            margin-bottom: 2.5rem;
            overflow: hidden;
        }

        .fine-table {
            width: 100%;
            border-collapse: collapse;
        }

        .fine-table th {
            padding: 1.2rem 1rem;
            text-align: left;
            font-weight: 600;
            color: #666;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .fine-table td {
            padding: 1.2rem 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .fine-table tr:last-child td {
            border-bottom: none;
        }

        .fine-table tr {
            transition: var(--transition);
        }

        .fine-table tr:hover {
            background: rgba(108, 99, 255, 0.02);
        }

        .book-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .book-cover {
            width: 40px;
            height: 55px;
            background: var(--gradient-bg);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .book-details {
            flex: 1;
        }

        .book-title {
            font-weight: 600;
            margin-bottom: 0.2rem;
            color: var(--dark-color);
        }

        .book-author {
            font-size: 0.85rem;
            color: #666;
        }

        .fine-status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }

        .fine-status-badge.unpaid {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
        }

        .fine-status-badge.paid {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .fine-status-badge.pending {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .overdue-days {
            font-weight: 600;
            color: var(--error-color);
        }

        .fine-amount-table {
            font-weight: 700;
            color: var(--error-color);
        }

        .action-button {
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .action-button.pay {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error-color);
        }

        .action-button.pay:hover {
            background: rgba(239, 68, 68, 0.2);
            transform: translateY(-2px);
        }

        .action-button.view {
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
        }

        .action-button.view:hover {
            background: rgba(108, 99, 255, 0.2);
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
        }

        .empty-icon {
            font-size: 4rem;
            color: var(--primary-color);
            opacity: 0.3;
            margin-bottom: 1.5rem;
        }

        .empty-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.8rem;
        }

        .empty-description {
            color: #666;
            max-width: 500px;
            margin: 0 auto 1.5rem;
        }

        /* History Card */
        .history-card {
            padding: 1.5rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            transition: var(--transition);
        }

        .history-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .history-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }

        .history-content {
            flex: 1;
        }

        .history-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.3rem;
        }

        .history-meta {
            display: flex;
            gap: 1.5rem;
            margin-top: 0.5rem;
        }

        .history-date, .history-method {
            font-size: 0.85rem;
            color: #666;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .history-amount {
            font-weight: 700;
            color: var(--success-color);
        }

        .history-invoice {
            padding: 0.5rem 1rem;
            background: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
            font-size: 0.9rem;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .history-invoice:hover {
            background: rgba(108, 99, 255, 0.2);
            transform: translateY(-2px);
        }

        /* Payment Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
            display: none;
            justify-content: center;
            align-items: center;
        }

        .modal {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            width: 95%;
            max-width: 500px;
            padding: 2rem;
            position: relative;
            animation: modalFadeIn 0.3s ease-out;
        }

        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-close {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            color: #999;
            font-size: 1.3rem;
            cursor: pointer;
            transition: var(--transition);
        }

        .modal-close:hover {
            color: var(--error-color);
            transform: rotate(90deg);
        }

        .modal-header {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
        }

        .modal-subtitle {
            color: #666;
            margin-top: 0.5rem;
        }

        .payment-details {
            margin-bottom: 1.5rem;
        }

        .payment-row {
            display: flex;
            justify-content: space-between;
            padding: 0.8rem 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .payment-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .payment-label {
            color: #666;
        }

        .payment-value {
            font-weight: 600;
            color: var(--dark-color);
        }

        .payment-value.total {
            font-weight: 700;
            color: var(--error-color);
            font-size: 1.1rem;
        }

        .payment-methods-modal {
            margin-bottom: 1.5rem;
        }

        .payment-method-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .payment-method-options {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
            gap: 1rem;
        }

        .payment-method-option {
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 1rem;
            text-align: center;
            cursor: pointer;
            transition: var(--transition);
        }

        .payment-method-option.active {
            border-color: var(--primary-color);
            background: rgba(108, 99, 255, 0.05);
        }

        .payment-method-option:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-sm);
        }

        .payment-method-icon {
            font-size: 1.8rem;
            margin-bottom: 0.8rem;
        }

        .payment-method-name {
            font-size: 0.9rem;
            font-weight: 500;
        }

        .payment-button {
            width: 100%;
            padding: 1rem;
            background: var(--error-color);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .payment-button:hover {
            background: #D22B2B;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }

        /* Receipt Modal */
        .receipt-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .receipt-logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .receipt-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.3rem;
        }

        .receipt-subtitle {
            color: #666;
            font-size: 0.9rem;
        }

        .receipt-info {
            background: var(--light-color);
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
        }

        .receipt-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.8rem;
        }

        .receipt-row:last-child {
            margin-bottom: 0;
        }

        .receipt-label {
            color: #666;
            font-size: 0.9rem;
        }

        .receipt-value {
            font-weight: 600;
            color: var(--dark-color);
            font-size: 0.9rem;
        }

        .receipt-items {
            margin-bottom: 1.5rem;
        }

        .receipt-item {
            display: flex;
            justify-content: space-between;
            padding: 0.8rem 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .receipt-item:last-child {
            border-bottom: none;
        }

        .receipt-item-name {
            font-weight: 500;
            color: var(--dark-color);
        }

        .receipt-item-price {
            font-weight: 600;
            color: var(--dark-color);
        }

        .receipt-total {
            display: flex;
            justify-content: space-between;
            padding: 1rem 0;
            border-top: 1px dashed rgba(0, 0, 0, 0.1);
            margin-top: 1rem;
        }

        .receipt-total-label {
            font-weight: 600;
            color: var(--dark-color);
        }

        .receipt-total-value {
            font-weight: 700;
            color: var(--error-color);
            font-size: 1.1rem;
        }

        .receipt-thank-you {
            text-align: center;
            margin-top: 2rem;
        }

        .receipt-message {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .download-receipt {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0.8rem 1.5rem;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            gap: 0.5rem;
            margin: 1.5rem auto 0;
            cursor: pointer;
            transition: var(--transition);
        }

        .download-receipt:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        /* Responsive styles */
        @media (max-width: 1200px) {
            .fine-summary {
                gap: 1.5rem;
            }
        }

        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
            }

            .fine-amount {
                font-size: 2.5rem;
            }

            .status-value {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            :root {
                --sidebar-width: 0;
            }

            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
                width: 280px;
            }

            .header {
                left: 0;
                padding-left: 1.5rem;
            }

            .main-content {
                margin-left: 0;
                padding: 1.5rem;
            }

            .welcome-message {
                font-size: 1.8rem;
            }

            .mobile-menu-toggle {
                display: flex;
            }

            .tabs {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
                scrollbar-width: none;
            }

            .tabs::-webkit-scrollbar {
                display: none;
            }

            .tab {
                padding: 1rem 1.5rem;
                white-space: nowrap;
            }

            .fine-table-container {
                overflow-x: auto;
            }

            .fine-table {
                min-width: 800px;
            }

            .history-card {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .history-meta {
                flex-direction: column;
                gap: 0.5rem;
            }
        }

        @media (max-width: 576px) {
            .fine-summary {
                padding: 1.5rem;
            }

            .fine-amount {
                font-size: 2.2rem;
            }

            .status-value {
                font-size: 1.3rem;
            }

            .fine-status {
                flex-wrap: wrap;
                gap: 1rem;
            }

            .header-actions {
                display: none;
            }

            .welcome-message {
                font-size: 1.5rem;
            }

            .empty-title {
                font-size: 1.3rem;
            }

            .modal {
                padding: 1.5rem;
            }

            .payment-method-options {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
<c:set var="activeTab" value="fines" scope="request"/>
<%@ include file="includes/sidebar.jsp" %>

<!-- Header -->
<header class="header">
    <h1 class="header-title">
        <i class="fas fa-rupee-sign"></i>
        My Fines
    </h1>
    <!-- Header Logout Button -->

</header>

<!-- Main Content -->
<main class="main-content">
    <!-- Fine Summary Card -->
    <div class="fine-summary">
        <div class="fine-total">
            <div class="fine-label">Total Outstanding Fines</div>
            <div class="fine-amount">
                <span class="fine-currency">Rs.</span>
                <c:out value="${totalFines}"/>
            </div>
        </div>
        <div class="fine-details">
            <div class="fine-status">
                <div class="status-item">
                    <span class="status-value">${unpaidFinesCount}</span>
                    <span class="status-label">Unpaid Fines</span>
                </div>
                <div class="status-item">
                    <div class="status-value">${totalDaysOverdue}</div>
                    <div class="status-label">Total Days Overdue</div>
                </div>
                <div class="status-item">
                    <div class="status-value">Rs.5</div>
                    <div class="status-label">Fine Per Day</div>
                </div>
            </div>
            <div class="fine-actions">
                <button class="pay-all-btn" id="payAllButton">
                    <i class="fas fa-wallet"></i>
                    Pay All Fines
                </button>
                <div class="fine-methods">
                    <div class="method-label">Payment Methods</div>
                    <div class="payment-methods">
                        <div class="payment-method active">UPI</div>
                        <div class="payment-method">Credit Card</div>
                        <div class="payment-method">Net Banking</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabs -->
    <div class="tabs">
        <div class="tab active" data-tab="current">Current Fines</div>
        <div class="tab" data-tab="history">Payment History</div>
    </div>

    <!-- Current Fines Tab -->
    <div class="tab-content active" id="current-tab">
        <div class="fine-table-container">
            <table class="fine-table">
                <thead>
                <tr>
                    <th>Book</th>
                    <th>Due Date</th>
                    <th>Days Overdue</th>
                    <th>Fine Amount</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty overdueBorrows}">
                        <tr>
                            <td colspan="6" class="text-center">
                                <div class="empty-state">
                                    <i class="fas fa-check-circle empty-icon"></i>
                                    <h3 class="empty-title">No Fines Due</h3>
                                    <p class="empty-description">You don't have any overdue books or unpaid fines at the moment. Keep up the good work!</p>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="borrow" items="${overdueBorrows}">
                            <tr>
                                <td>
                                    <div class="book-info">
                                        <div class="book-cover">
                                            <i class="fas fa-book"></i>
                                        </div>
                                        <div class="book-details">
                                            <h4 class="book-title">${borrow.book.title}</h4>
                                            <p class="book-author">${not empty borrow.book.authors ? borrow.book.authors[0].authorName : 'Unknown'}</p>
                                        </div>
                                    </div>
                                </td>
                                <td><fmt:formatDate value="${borrow.dueDate}" pattern="dd/MM/yyyy"/></td>
                                <td class="overdue-days">
                                    <c:set var="today" value="<%= new java.util.Date() %>" />
                                    <c:set var="diffInMillis" value="${today.time - borrow.dueDate.time}" />
                                    <c:set var="diffInDays" value="${diffInMillis / (1000 * 60 * 60 * 24)}" />
                                    <fmt:formatNumber value="${diffInDays}" pattern="#0" var="days" />
                                        ${days} day<c:if test="${days != 1}">s</c:if>
                                </td>
                                <td class="fine-amount-table">
                                    <c:set var="finePerDay" value="5" />
                                    <c:set var="totalFine" value="${days * finePerDay}" />
                                    Rs.${totalFine}
                                </td>
                                <td><span class="fine-status-badge unpaid">Unpaid</span></td>
                                <td>
                                    <button class="action-button pay" onclick="openPaymentModal('${borrow.book.title}', ${totalFine})">
                                        <i class="fas fa-credit-card"></i> Pay Now
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Payment History Tab -->
    <div class="tab-content" id="history-tab">
        <!-- If no payment history -->
        <!-- <div class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-history"></i>
            </div>
            <h2 class="empty-title">No Payment History</h2>
            <p class="empty-description">You haven't made any fine payments yet. When you pay fines, your payment history will appear here.</p>
        </div> -->

        <!-- If payment history exists -->
        <div class="history-card">
            <div class="history-icon">
                <i class="fas fa-check"></i>
            </div>
            <div class="history-content">
                <h3 class="history-title">Fine Paid for "The Clean Coder"</h3>
                <div class="history-amount">Rs.35</div>
                <div class="history-meta">
                    <span class="history-date">
                        <i class="fas fa-calendar-alt"></i>
                        15/04/2025
                    </span>
                    <span class="history-method">
                        <i class="fas fa-credit-card"></i>
                        UPI (Google Pay)
                    </span>
                </div>
            </div>
            <button class="history-invoice" onclick="openReceiptModal('The Clean Coder', 35)">
                <i class="fas fa-file-invoice"></i>
                Receipt
            </button>
        </div>

        <div class="history-card">
            <div class="history-icon">
                <i class="fas fa-check"></i>
            </div>
            <div class="history-content">
                <h3 class="history-title">Fine Paid for "Operating System Concepts"</h3>
                <div class="history-amount">Rs.20</div>
                <div class="history-meta">
                    <span class="history-date">
                        <i class="fas fa-calendar-alt"></i>
                        05/04/2025
                    </span>
                    <span class="history-method">
                        <i class="fas fa-credit-card"></i>
                        Credit Card
                    </span>
                </div>
            </div>
            <button class="history-invoice" onclick="openReceiptModal('Operating System Concepts', 20)">
                <i class="fas fa-file-invoice"></i>
                Receipt
            </button>
        </div>
    </div>

    <!-- Payment Modal -->
    <div class="modal-overlay" id="paymentModal">
        <div class="modal">
            <div class="modal-close" onclick="closeModal('paymentModal')">
                <i class="fas fa-times"></i>
            </div>
            <div class="modal-header">
                <h2 class="modal-title">Pay Fine</h2>
                <p class="modal-subtitle">Complete your payment to clear the fine</p>
            </div>
            <div class="payment-details">
                <div class="payment-row">
                    <div class="payment-label">Book</div>
                    <div class="payment-value" id="modalBookTitle">Introduction to Database Systems</div>
                </div>
                <div class="payment-row">
                    <div class="payment-label">Fine Amount</div>
                    <div class="payment-value total" id="modalFineAmount">Rs.25</div>
                </div>
            </div>
            <div class="payment-methods-modal">
                <div class="payment-method-label">Select Payment Method</div>
                <div class="payment-method-options">
                    <div class="payment-method-option active" onclick="selectPaymentMethod(this)">
                        <div class="payment-method-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <div class="payment-method-name">UPI</div>
                    </div>
                    <div class="payment-method-option" onclick="selectPaymentMethod(this)">
                        <div class="payment-method-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <div class="payment-method-name">Card</div>
                    </div>
                    <div class="payment-method-option" onclick="selectPaymentMethod(this)">
                        <div class="payment-method-icon">
                            <i class="fas fa-university"></i>
                        </div>
                        <div class="payment-method-name">Net Banking</div>
                    </div>
                    <div class="payment-method-option" onclick="selectPaymentMethod(this)">
                        <div class="payment-method-icon">
                            <i class="fas fa-wallet"></i>
                        </div>
                        <div class="payment-method-name">Wallet</div>
                    </div>
                </div>
            </div>
            <button class="payment-button" onclick="processPayment()">Pay Now</button>
        </div>
    </div>

    <!-- Receipt Modal -->
    <div class="modal-overlay" id="receiptModal">
        <div class="modal">
            <div class="modal-close" onclick="closeModal('receiptModal')">
                <i class="fas fa-times"></i>
            </div>
            <div class="receipt-header">
                <div class="receipt-logo">
                    <i class="fas fa-book-reader"></i>
                    LibraryMS
                </div>
                <h2 class="receipt-title">Payment Receipt</h2>
                <p class="receipt-subtitle">Fine Payment Confirmation</p>
            </div>
            <div class="receipt-info">
                <div class="receipt-row">
                    <div class="receipt-label">Receipt ID</div>
                    <div class="receipt-value">FP-25042505</div>
                </div>
                <div class="receipt-row">
                    <div class="receipt-label">Payment Date</div>
                    <div class="receipt-value">15/04/2025</div>
                </div>
                <div class="receipt-row">
                    <div class="receipt-label">Payment Method</div>
                    <div class="receipt-value">UPI (Google Pay)</div>
                </div>
            </div>
            <div class="receipt-items">
                <div class="receipt-item">
                    <div class="receipt-item-name" id="receiptBookTitle">The Clean Coder</div>
                    <div class="receipt-item-price" id="receiptFineAmount">Rs.35</div>
                </div>
            </div>
            <div class="receipt-total">
                <div class="receipt-total-label">Total Paid</div>
                <div class="receipt-total-value" id="receiptTotalAmount">Rs.35</div>
            </div>
            <div class="receipt-thank-you">
                <div class="receipt-message">Thank you for your payment!</div>
                <p class="receipt-subtitle">This fine has been cleared from your account.</p>
                <button class="download-receipt">
                    <i class="fas fa-download"></i>
                    Download Receipt
                </button>
            </div>
        </div>
    </div>

    <script>
        // Mobile menu toggle functionality
        const mobileMenuToggle = document.getElementById('mobileMenuToggle');
        const sidebar = document.getElementById('sidebar');

        if (mobileMenuToggle) {
            mobileMenuToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');

                // Change icon based on sidebar state
                const icon = this.querySelector('i');
                if (sidebar.classList.contains('active')) {
                    icon.classList.remove('fa-bars');
                    icon.classList.add('fa-times');
                } else {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            });
        }

        // Tab functionality
        const tabs = document.querySelectorAll('.tab');
        const tabContents = document.querySelectorAll('.tab-content');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // Remove active class from all tabs
                tabs.forEach(t => t.classList.remove('active'));
                // Add active class to clicked tab
                this.classList.add('active');

                // Hide all tab contents
                tabContents.forEach(content => content.classList.remove('active'));
                // Show the corresponding tab content
                const tabId = this.getAttribute('data-tab');
                document.getElementById(tabId + '-tab').classList.add('active');
            });
        });

        // Payment method selection
        const paymentMethods = document.querySelectorAll('.payment-method');

        paymentMethods.forEach(method => {
            method.addEventListener('click', function() {
                // Remove active class from all methods
                paymentMethods.forEach(m => m.classList.remove('active'));
                // Add active class to clicked method
                this.classList.add('active');
            });
        });

        // Modal functionality
        function openPaymentModal(bookTitle, fineAmount) {
            const modal = document.getElementById('paymentModal');
            const modalBookTitle = document.getElementById('modalBookTitle');
            const modalFineAmount = document.getElementById('modalFineAmount');

            modalBookTitle.textContent = bookTitle;
            modalFineAmount.textContent = Rs.${fineAmount};

            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden'; // Prevent scrolling when modal is open
        }

        function openReceiptModal(bookTitle, fineAmount) {
            const modal = document.getElementById('receiptModal');
            const receiptBookTitle = document.getElementById('receiptBookTitle');
            const receiptFineAmount = document.getElementById('receiptFineAmount');
            const receiptTotalAmount = document.getElementById('receiptTotalAmount');

            receiptBookTitle.textContent = bookTitle;
            receiptFineAmount.textContent = Rs.${fineAmount};
            receiptTotalAmount.textContent = Rs.${fineAmount};

            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            modal.style.display = 'none';
            document.body.style.overflow = 'auto'; // Re-enable scrolling
        }

        // Payment methods functionality in modal
        function selectPaymentMethod(element) {
            const paymentOptions = document.querySelectorAll('.payment-method-option');
            paymentOptions.forEach(option => option.classList.remove('active'));
            element.classList.add('active');
        }

        // Pay all button
        document.getElementById('payAllButton').addEventListener('click', function() {
            openPaymentModal('All Overdue Books', ${totalFines});
        });

        // Process payment
        function processPayment() {
            // In a real app, this would handle the payment processing logic
            // For demo purposes, we'll just show success and close the modal

            // Here we would typically:
            // 1. Send an AJAX request to the server to process payment
            // 2. On success, update the UI to reflect the payment
            // 3. Show a confirmation message

            alert('Payment successful! Your fine has been cleared.');
            closeModal('paymentModal');

            // Refresh the page to see updated fines
            // In a real app, we would update just the specific parts of the UI
            // location.reload();
        }

        // Add animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            const fineCards = document.querySelectorAll('.history-card');

            fineCards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100 * index);
            });
        });
    </script>
</main>
</body>
</html>