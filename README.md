# Healthcare Database System

This is my Healthcare Relational Database System Project —  used to explore healthcare datasets through data cleaning, analysis, visualization, and modeling. The goal is to extract actionable insights that can support decision-making in healthcare contexts.


# Dataset


The datasets used are synthetic/mock data that is simulated to represent a typical hospital or clinic system.  These files are included as .csv files.


# Project Structure/Database Schema

Table Structure

Patients: Stores personal info about patients

Doctors: Stores doctor details and specialties

Appointments: Manages scheduled consultations

Diagnoses: Records post-appointment medical observations and treatment


# Relationships:

1. Appointments link patients to doctors

2. Diagnoses are tied to appointments


# Data Import
Loads CSV files into MySQL using LOAD DATA INFILE

patients.csv

doctors.csv

appointments.csv

diagnoses.csv


# Queries Included
Patient filtering: Find patients born after a specific date

Appointment joins: Display upcoming appointments with doctor and patient info

Doctor stats: Count of doctors by specialty


# Requirements
MySQL Server (8.0 or later)
MySQL Workbench or any SQL client

Ensure the following for file loading:
secure_file_priv is set correctly
Your MySQL user has FILE privileges
