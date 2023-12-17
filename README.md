# Cognitive Load Guidance


## Purpose
The application aims to enhance clincian training by providing teams with information on cognitive load and timing during surgeries to better access clincians and knowing what should be their typical supervision level. 

## Definitions
- **Cardiac Surgeries Modeled**: Aortic Valve Replacement (AVR) and Coronary Artery Bypass Grafting (CABG).
- **Surgery Phases**: Defined stages from patient arrival to departure.
- **Process Execution Events**: Detailed steps corresponding to surgery phases.

## Current Focus
- **Phase 12 - Separate from bypass**: A critical phase consisting of substeps impacting patient safety.

## Teams and Parameters
- **Specialty Teams**: Anes (Anesthesia), Nurs (Nursing), Perf (Perfusion), Surg (Surgery).
- **HRV Parameters of Interest**: Linked to cognitive load assessment.

## Functional Requirements
- Collect cognitive load data via OpenICE API.
- Display real-time surgery phase and operation timelapse.
- Integrate data for comprehensive team status overview.
- Provide Smart Checklist instructions for each team.
- Ensure easy navigation within a unified dashboard.

## Non-Functional Requirements
- **Security and Privacy**: Stringent data protection measures.
- **Reliability and Availability**: Backup system for uninterrupted availability.
- **Scalability**: Ability to handle numerous users and real-time updates.
- **Usability**: Quick, straightforward access amid complex scenarios.
- **Performance**: Swift information retrieval even under heavy load.
- **Maintainability**: Well-documented, easily updatable design.

This application addresses critical communication challenges in the OR, aiming to foster a safer environment through improved coordination and reduced cognitive load for healthcare teams.

### 1. Install Flutter

1. **Download Flutter**: Go to the [Flutter official website](https://flutter.dev/) and download the Flutter SDK for macOS.
   
2. **Extract the ZIP file**: Once downloaded, extract the contents of the downloaded ZIP file to a location on your machine, preferably in your home directory or any desired location.

3. **Add Flutter to Path**: Open Terminal and run the following command to add Flutter to your PATH variable:
   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```
   You might want to add this command permanently to your `.bash_profile` or `.zshrc` file.

4. **Run Flutter Doctor**: In Terminal, run `flutter doctor`. This command checks your environment and displays a report of the status of your Flutter installation. It will also guide you through any additional steps needed for setup (like installing additional dependencies).

### 2. Setting Up an Editor

1. **Choose an Editor**: You can use a variety of editors with Flutter. Popular choices include Visual Studio Code, Android Studio, or IntelliJ IDEA.

2. **Install Editor Plugins**: Install the Flutter and Dart plugins in your chosen editor. This step will provide syntax highlighting, autocompletion, and additional Flutter-specific features.

### 3. Running a Flutter Application

1. **Get the Application Code**: Obtain the Flutter application code, either by cloning a Git repository or creating a new Flutter project using the command:
   ```bash
   flutter create my_flutter_app
   ```

2. **Navigate to the Project Directory**: Use Terminal to navigate to your Flutter project directory:
   ```bash
   cd path/to/your/flutter_project
   ```

3. **Connect a Device or Use an Emulator/Simulator**:
   - **Physical Device**: Connect your Android/iOS device via USB and ensure USB debugging is enabled (for Android) or Trust the device (for iOS).
   - **Emulator/Simulator**: Open an emulator or simulator for Android/iOS using Android Studio, Xcode, or the command line.

4. **Run the App**:
   - **For Android**:
     ```bash
     flutter run
     ```
   - **For iOS**:
     ```bash
     flutter run -d <device_id>
     ```
     Replace `<device_id>` with the identifier of your iOS device or simulator.

5. **Observing Output**: Your application should start building and eventually launch on the connected/emulated device.

### Additional Tips:

- **Hot Reload**: While your app is running (via `flutter run`), you can make changes to your code and save. Flutter’s hot reload feature will reflect these changes almost instantly in the running app.

Remember, Flutter's official documentation is a great resource for troubleshooting or diving deeper into any specific topic. Good luck with your Flutter journey!