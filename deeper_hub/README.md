# Keystone 6 Project with GrapesJS Editor

Welcome to your Keystone 6 project, now enhanced with a powerful WYSIWYG GrapesJS page builder!

This project has been modified from the standard Keystone starter to replace the default `document` field with a fully integrated GrapesJS editor for the `Post` list. This allows for rich, free-form page and content creation directly within the Keystone Admin UI.

## Key Changes & Features

### 1. GrapesJS Custom Field Integration

The core of the modification is a custom Keystone 6 field that wraps the GrapesJS editor.

- **Location:** The implementation code for the custom field resides in the `./custom-fields/grapesjs/` directory.
- **Backend (`index.ts`):**
    - Defines a new field type called `grapesJsField`.
    - To ensure compatibility with SQLite, the editor's content (HTML and CSS) is packaged as a JSON object, which is then converted to a `String` before being saved to the database.
    - When data is retrieved, this string is parsed back into a JSON object for the Admin UI.
- **Frontend (`views.tsx`):**
    - This file contains the React components required by Keystone to render the field in the Admin UI.
    - It exports `Field` (the main editor component), `Cell` (for the list view), `CardValue` (for relationship cards), and a `controller` to manage the field's state and data flow.
    - It initializes the GrapesJS editor, loads the saved content into it, and sends updated content back to be saved.

### 2. Schema Modification

- In `schema.ts`, the `Post` list's `content` field has been changed from the default `document` field to our new `grapesJsField()`.

### 3. Added Dependencies

The following npm packages were added to support this integration:
- `grapesjs`: The core GrapesJS library.
- `grapesjs-preset-webpage`: A default preset for GrapesJS that provides a standard set of blocks and tools for page building.

## Getting Started

To run this project and see the GrapesJS editor in action, follow these steps:

1.  **Install Dependencies:**
    If you haven't already, or if you encounter any issues, install all the necessary packages.
    ```bash
    npm install
    ```

2.  **Run the Development Server:**
    This command starts the Keystone server and opens the Admin UI.
    ```bash
    npm run dev
    ```

3.  **Access the Admin UI:**
    Open your browser and navigate to [http://localhost:3000](http://localhost:3000).

4.  **Create an Admin User:**
    If this is the first time you're running the project, Keystone will prompt you to create an initial admin user.

5.  **Use the GrapesJS Editor:**
    - Once logged in, navigate to the **Posts** list from the left-hand menu.
    - Click **Create Post** or edit an existing one.
    - You will see the GrapesJS editor in place of the standard content field. You can now build your page visually!

---
*This README was updated to reflect the GrapesJS integration.*



'''json

cls & curl -X POST -H "Content-Type: application/json" -d "{\"serverName\": \"deeper-server-instance-1\"}" http://localhost:3000/api/report-server-down

'''
