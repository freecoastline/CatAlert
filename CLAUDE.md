# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CatAlert is an iOS application for monitoring cat care activities including food, water, and play time. The app uses a reminder system with local notifications to help cat owners track their pet's daily needs.

## Development Commands

### Building and Running
- Open `CatAlert.xcodeproj` in Xcode to build and run the application
- The project uses UIKit with Storyboards and programmatic UI
- Uses SnapKit for Auto Layout constraints (imported via Swift Package Manager)

### Project Structure
```
CatAlert/
├── Managers/           # Core business logic managers
├── Model/             # Data models (Codable structs)
├── CatStatus/         # Status tracking UI components
├── Reminder/          # Reminder management UI
├── Assets.xcassets/   # App icons and assets
└── Base.lproj/        # Storyboards and localization
```

## Architecture Overview

### Core Data Flow
The app follows a manager-based architecture with three main managers:

1. **ReminderManager** (ObservableObject singleton)
   - Manages active reminders and today's activities
   - Central state management for reminder CRUD operations
   - Published properties: `activeReminders: [CatReminder]`, `todayActivities: [ActivityRecord]`

2. **DataPersistenceManager** (Singleton pattern)
   - Handles JSON file persistence in `Documents/CatDoc/` directory
   - Uses ISO8601 date encoding strategy
   - Generic save/load functions for Codable types
   - Files: `reminders.json`, `activity_records.json`

3. **NotificationManager**
   - Manages UserNotifications framework integration
   - Schedules recurring notifications based on reminder times
   - Custom notification messages for each CatCareType (food, water, play)

### Key Data Models

**CatReminder** (Codable)
- Core reminder entity with UUID, title, type, frequency
- Contains `scheduledTime: [ReminderTime]` array for multiple daily times
- `ReminderTime` struct validates hour (0-24) and minute (0-59) ranges

**ActivityRecord** (Codable)
- Tracks individual care activities generated from reminders
- Links to reminder via `reminderId: UUID`
- Status tracking: pending → completed/skipped/expired

### UI Architecture
- **CatTabbarController**: Custom tab bar with rounded corners and shadow
- **CatDailyCareViewController**: Collection view for care activity cards
- **CatStatus/**: Status tracking components with custom card views
- **Reminder/**: Full reminder management flow (Add/Edit/Settings/TypeSelection)

### Data Persistence Strategy
- All data stored as JSON files in dedicated `CatDoc` directory
- Manager pattern separates persistence logic from business logic
- Error handling with Swift's `throws` mechanism
- Incremental updates supported (add, update, delete operations)

### Notification System
- Permission-based local notifications using UNUserNotificationCenter
- Notification identifiers follow pattern: `{reminderUUID}_{hour}_{minute}`
- Async cancellation for pending notifications when reminders are disabled
- Localized Chinese notification messages with emoji

## Important Implementation Notes

- Models conform to Codable for automatic JSON serialization
- ReminderTime includes failable initializer for validation
- NotificationManager uses async/await for notification management
- CatTabbarController customizes appearance with CAShapeLayer
- File organization moved from CatAlertTests/ to proper CatAlert/ structure

## Data Directory
The app creates and manages a `CatDoc` subdirectory in the iOS Documents folder for all persistent data storage.