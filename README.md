# convo_test

A test project for Convo

## Overview

The convo_test app connects to the https://open-meteo.com/ to provide a weather report for a particular location.  
The app follows a **Clean Architecture** design pattern, with **BloC** for state management, **Dio** for networking, and **Mockito** for API testing.

## Architecture

The project follows a **Clean Architecture** design pattern that organizes code distribution in a specific manner, with three primary outer layers as folders.

### Layers:
1. **Presentation Layer**:
    - Manages UI, Widgets, and State Management (using **BloC**).

2. **Domain Layer**:
    - Contains business logic, use cases, and entities. We have the Report entity, and getReport usecase as the main objects.

3. **Data Layer**:
    - Manages repositories, networking (using **Dio**), and data sources. In this case, we can look for data to a remote source (API), or a local one (shared preferences).

## State Management

This project uses the BLoC (Business Logic Component) pattern to manage state, ensuring a clean separation between the UI and business logic layers.
The ReportBloc in this project processes user input (latitude and longitude) and fetches weather reports either from a cache or by making an API call.
It handles events like loading, success (report fetched), and error (failure in fetching the report).

## Testing

### Unit Tests

Created unit tests for the domain and data layer.

### Widget Tests

There are 3 main widgets used: the ReportPage itself, the input form, and the reportList. Created test for each of them

