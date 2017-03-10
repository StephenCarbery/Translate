# Translate
A simple iOS translation app written in Swift, using MyMemory Translate API (https://mymemory.translated.net/doc/spec.php).

The app is a translation app where the user enters text into the text box at the top of the screen. The user can then select from 3 languages, French, Spanish and German, using the UIPicker near the bottom.

As the user selects their destination language using the UIPicker, the country flag and text on the right of the app changes to that of the language selected. This is done using a switch statement  in the pickerView(..didSelectRow) function.
When the user presses the translate button, a switch statement determines what language request the app is going to make to the server.
The request to the server is done using dataTask.

For the ui activity indicator, Progress indicator was taken from stack overflow that allows for  the text “loading” to be displayed along with the indicator. Link for the indicator class: http://stackoverflow.com/questions/28785715/how-to-display-an-activity-indicator-with-text-on-ios-8-with-swift 

The dispatchQueue manages the execution of changes to the UI, by stopping the animation of the activity indicator and showing the translated text in the middle text box. 

All images used in the app came from https://icons8.com/. The app icon itself was made in Paint 2 with the correct sizes being done with https://makeappicon.com/
