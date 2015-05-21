# Codepath Week 3: Mailbox

### Description:
This is a fake Mailbox iOS application that simulates archiving and interacting with emails using gesture recgonizers.

### Time spent:
7.5 hours spent in total

### Completed user stories:

**On dragging the message left...**
* [x] Initially, the revealed background color should be gray.
* [x] As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
* [x] After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
  * [x] Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
* [x] After 260 pts, the icon should change to the list icon and the background color should change to brown.
  * [x] Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.

**On message tap...**
* [x] User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.

**On dragging the message right...**
* [x] Initially, the revealed background color should be gray.
* [x] As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
* [x] After 60 pts, the archive icon should start moving with the translation and the background should change to green.
  * [x] Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
* [x] After 260 pts, the icon should change to the delete icon and the background color should change to red.
  * [x] Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.

**Optional**
* [x] Optional: Panning from the edge should reveal the menu
  * [x] Optional: If the menu is being revealed when the user lifts their finger, it should continue revealing.
  * [x] Optional: If the menu is being hidden when the user lifts their finger, it should continue hiding.
* [ ] Optional: Tapping on compose should animate to reveal the compose view.
* [ ] Optional: Tapping the segmented control in the title should swipe views in from the left or right.
* [ ] Optional: Shake to undo.

### Notes:
My storyboard became really crowded to the point where it became hard to manipulate images and views that were further back in the layer stack. Unsure what the proper procedures are for dealing with that particular issue.

### Walkthrough of all user stories:
![Video Walkthrough](mailbox.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).