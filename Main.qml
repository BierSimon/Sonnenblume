import QtQuick
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Bewegung durch FakeArduino")


    //mit Sonnenblume

    Image {
        id: sensorImage
        anchors.centerIn: parent
        width: 400
        height: 400
        source: currentImage  // ← das Bild, das angezeigt wird
        fillMode: Image.PreserveAspectFit
    }

    property string currentImage: "file://users/lillisauer/Connect/State2.png"  // Startbild

    Connections {
        target: arduinoReader
        function onValueChanged(value) {
            if (value < 200) {
                currentImage = "file://users/lillisauer/Connect/State3.png";
            } else if (value < 600) {
                currentImage = "file://users/lillisauer/Connect/State4.png";
            } else {
                currentImage = "file://users/lillisauer/Connect/State5.png";
            }
        }
    }





    /* Nur mit Rechteck
// Das Element das sich bewegen soll
    Rectangle {
        id: mover
        width: 100
        height: 100
        color: "blue"
        y: 190  // zentriert auf der Y-Achse
        x: sensorValue  // Steuerung über C++ Signal

        // Wert, den wir von C++ setzen
        property int sensorValue: 0

        // Glatte Animation bei Bewegung
        Behavior on x {
            NumberAnimation { duration: 300 }
        }
// Fängt das Signal vom Arduino ab
        Connections {
            target: arduinoReader
            function onValueChanged(value) {
                mover.sensorValue = value / 2
            }
        }

    } */
}
