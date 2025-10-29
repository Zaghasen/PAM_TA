# TODO: Integrate Hive Database for Login with Encryption and Sessions

## Steps to Complete

1. **Add Dependencies to pubspec.yaml**

   - Add hive, hive_flutter, hive_crypto, shared_preferences, crypto packages.

2. **Create User Model**

   - Create lib/models/user.dart with Hive annotations for storing user data (username, hashed password, etc.).

3. **Create AuthService**

   - Create lib/services/auth_service.dart to handle user registration, login, logout, and session management using Hive and shared_preferences.

4. **Initialize Hive in main.dart**

   - Modify lib/main.dart to initialize Hive and check session state to decide initial screen.

5. **Modify LoginScreen**

   - Update lib/screens/login_screen.dart to use AuthService for authentication instead of hardcoded checks.
   - Add registration functionality if needed (e.g., a register button).

6. **Test Implementation**
   - Run the app to ensure login works with database, encryption, and sessions.
   - Verify that user data is stored securely and sessions persist.

## Notes

- Use SHA-256 for password hashing via crypto package.
- Encrypt Hive boxes using hive_crypto.
- Use shared_preferences for simple session flags (e.g., isLoggedIn).
