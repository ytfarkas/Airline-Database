# Airline Database  
  
A web-based flight booking and management platform supporting airline operations across multiple user roles.  
  
## Overview  
  
The Airline Database is a three-tier JSP/MySQL web application that enables customers to search flights, make reservations, and manage bookings, while providing representatives with customer service tools and administrators with business intelligence capabilities.  
  
## Technology Stack  
  
- **Web Server**: Apache Tomcat  
- **Application Framework**: JavaServer Pages (JSP)  
- **Database**: MySQL (`336AirlineProject`)  
- **JDBC Driver**: MySQL Connector/J 9.2.0  
- **Connection Layer**: `ApplicationDB.java`  
  
## Key Features  
  
### Customer Self-Service  
- Flight search by origin, destination, date, and class  
- One-way and round-trip booking with class selection (Economy, Business, First)  
- View and manage reservations  
- Submit support questions and browse Q&A  
  
### Representative Operations  
- Create/edit/cancel bookings for customers  
- Maintain aircraft, airport, and flight data  
- Answer customer questions  
  
### Administrative Intelligence  
- User account management across all roles  
- Monthly sales reports and booking trends  
- Revenue analysis by flight, airline, and customer  
- Operational metrics and top customer identification  
  
## Database Schema  
  
The system uses 13 interconnected tables organized into four modules:  
  
**Core Entities**: `Account`, `Airline_Company`, `Airport`, `Aircraft`  
  
**Flight Management**: `Flight_Schedule`, `Flight_Operating_Days`, `Flight_Avalibility`  
  
**Booking System**: `Bookings`, `Ticket`, `Waitlist`  
  
**Support System**: `Question`, `Answer`  
  
## User Roles  
  
Three role-based access levels defined in the `Account` table:  
  
| Role | Access Level | Home Page |  
|------|-------------|-----------|  
| **Administrator** | Full system access, user management, all reports | `adminHome.jsp` |  
| **Representative** | Booking operations, data maintenance, customer support | `repHome.jsp` |  
| **Customer** | Self-service flight search and booking management | `customerHome.jsp` |  


## Default test accounts (username/password):
- Customer: c / c
- Representative: r / r
- Administrator: a / a

## Application Entry Point
Access the system through login.jsp, which routes users to role-specific dashboards based on their account type.

## Data Model Highlights
Flight Instance Model
The system separates static flight schedules from dynamic flight instances:

- **Flight_Schedule**: Recurring routes (e.g., DA100 JFK→SFO)

- **Flight_Operating_Days**: Operating days (Monday, Wednesday, etc.)

- **Flight_Avalibility**: Bookable instances with specific dates, aircraft, and pricing

## Pricing Structure
- **Base Price**
- **Class Surcharge** (Economy: $0, Business: +$50, First: +$100)
- **Booking Fee** (fixed per booking)

##Multi-Leg Journeys
- Round-trip bookings use composite keys in the Ticket table, allowing a single Booking_ID to contain multiple flight segments.

## System Boundaries

**Provides**:
- Real-time flight search and booking
- Multi-role access control
- Booking lifecycle management
- Business intelligence reporting
- Customer support Q&A

**Does Not Provide**:
- Payment processing
- External airline API integrations
- Real-time flight tracking
- Seat selection UI
- Email notifications


  
