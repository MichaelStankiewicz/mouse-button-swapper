# mouse-button-swapper
This project provides a more convenient means to swap the primary mouse button on a Windows device.

It was designed to be used in a elementary school setting to assist children with quickly and easily swapping the primary mouse button for left and right-handed orientations.

## What this Project Contains:
The code contains three main files: 

   * MouseButtonSwapper.cmd: This is the primary means to call the code.  Simply double-click on this file to execute the program.
   * MouseButtonSwapper: This is a shortcut to the CMD file above created for convenience.  If copied from a central share, the path will need to be updated to reflect the UNC path of the source.
   * Set-PrimaryMouseButton.ps1: This is the main implementation that presents the WinForm to the caller and sets the primary mouse button based on the button clicked.

## How to Use
   * Download the repo.
   * Double-click on the MouseButtonSwapper.cmd file.

## How it Works
After clicking the CMD file, you will be presented with a dialogue box asking which hand you prefer to use with the mouse.  The form will present two buttons: a Right and a Left button.  Based on the orientation selected, the primary mouse button will be activated on the system mouse.

## Additional Setup / Information
In a classroom setting, it may be best to create a shortcut to the .CMD file and place it on the desktop of each learner.  This can be achieved by storing the solution in a centralized share that is accessible by each learner's workstation - in this option, the shortcut file would need to be updated to reflect the central share location.  Or, you can copy the complete solution to each workstation, create a shortcut from the local file and place this on the desktop of each learner.  The former solution is the recommended one, if it is feasible.
