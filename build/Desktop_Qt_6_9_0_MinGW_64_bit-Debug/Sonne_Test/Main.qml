import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Sonne"

    property real sonnenStand: 1.0 // 0 = Nacht, 1 = Tag

    function lerp(a, b, t) {
        return a + (b - a) * t
    }

    Rectangle {
        id: sky
        anchors.fill: parent

        // Himmel: oben hell, unten dunkel
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Qt.rgba(
                    lerp(0.7, 0.1, sonnenStand),
                    lerp(0.85, 0.2, sonnenStand),
                    lerp(0.95, 0.4, sonnenStand),
                    1.0)
            }
            GradientStop {
                position: 1.0
                color: Qt.rgba(
                    lerp(0.4, 0.05, sonnenStand),
                    lerp(0.6, 0.1, sonnenStand),
                    lerp(0.8, 0.2, sonnenStand),
                    1.0)
            }
        }

        // Sonne selbst
        Rectangle {
            id: sun
            width: 80
            height: 80
            radius: 40
            color: "yellow"
            border.color: "#ffaa00"
            border.width: 2
            x: parent.width / 2 - width / 2
            y: sonnenStand * (parent.height - height - 100)
        }

        // Glow-Ring um die Sonne
        Rectangle {
            id: glow1
            width: 140
            height: 140
            radius: 70
            color: Qt.rgba(1.0, 0.9, 0.4, 0.15)
            anchors.centerIn: sun
        }

        Rectangle {
            id: glow2
            width: 300
            height: 300
            radius: 150
            color: Qt.rgba(1.0, 0.9, 0.4, 0.15)
            anchors.centerIn: sun
        }

        // Slider zur Steuerung des Sonnenstands
        Slider {
            id: sunSlider
            from: 0
            to: 1
            value: sonnenStand
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 30
            width: 200
            onValueChanged: sonnenStand = value
        }

        // Textanzeige für Sonnenstand
        Text {
            text: "Sonnenstand: " + (sonnenStand * 100).toFixed(0) + "%"
            anchors.bottom: sunSlider.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 10
            font.pixelSize: 16
            color: "white"
        }
    }
}
