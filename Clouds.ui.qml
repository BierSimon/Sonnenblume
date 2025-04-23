import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Particles 2.15

Item {
    id: root
    width: 800
    height: 600

    // Automatischer State-Wechsel durch Slider
    state: rainSlider.value === 0 ? "clear"
         : rainSlider.value === 1 ? "fewClouds"
         : rainSlider.value === 2 ? "cloudy"
         : rainSlider.value === 3 ? "rainy"
         : "heavyRain"

    // Hintergrund & Wolken
    Rectangle {
        id: sky
        anchors.fill: parent
        color: "#d0e8ff"

        Image { id: cloud1; x: -500; y: 5; width: 400; opacity: 0; source: "wolke1.png"; fillMode: Image.PreserveAspectFit }
        Image { id: cloud2; x: -500; y: 80; width: 450; opacity: 0; source: "wolke4.png"; fillMode: Image.PreserveAspectFit }
        Image { id: cloud3; x: -500; y: 50; width: 480; opacity: 0; source: "wolke1.png"; fillMode: Image.PreserveAspectFit }
        Image { id: cloud4; x: -500; y: 90; width: 500; opacity: 0; source: "wolke1.png";fillMode: Image.PreserveAspectFit }
        Image { id: cloud5; x: -700; y: 15;  width: 350; opacity: 0; source: "wolke4.png";fillMode: Image.PreserveAspectFit }
        Image { id: cloud6; x: -1000; y: 20;  width: 300; opacity: 0; source: "regenWolke.png";fillMode: Image.PreserveAspectFit }
        Image { id: cloud7; x: 600; y: 10;  width: 200; opacity: 0; source: "regenWolke.png";fillMode: Image.PreserveAspectFit }

        // Partikelsystem für Regen
        ParticleSystem {
            id: rainSystem
            running: root.state === "rainy" || root.state === "heavyRain"
        }

        Emitter {
            id: rainEmitter
            system: rainSystem
            width: parent.width * 1             // nicht mehr bildschirmbreit
            height: 20                          // schmaler Regenbereich
            x: (parent.width - width) / 2       // zentriert (horizontalCenter ohne anchors)
            y: parent.height * 0.35             // weiter unten (unterhalb der Wolken)
            emitRate: root.state === "rainy" || root.state === "heavyRain" ? 200 : 0
            lifeSpan: 2000
            velocity: AngleDirection { angle: 90; magnitude: 400 }
            enabled: root.state === "rainy" || root.state === "heavyRain"
        }


        ImageParticle {
            system: rainSystem
            source: "tropfenThin.png"
            width: 5
            height: 15
            opacity: 0.6
        }

        // Slider
        Slider {
            id: rainSlider
            from: 0
            to: 4
            stepSize: 1
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.6
            height: 40
        }
    }

    // STATES
    states: [
        State {
            name: "clear"
            PropertyChanges { target: sky; color: "#d0e8ff" }
            PropertyChanges { target: cloud1; x: -500; opacity: 0 }
            PropertyChanges { target: cloud2; x: -500; opacity: 0 }
            PropertyChanges { target: cloud3; x: -500; opacity: 0 }
            PropertyChanges { target: cloud4; x: -500; opacity: 0 }
            PropertyChanges { target: cloud5; x: -500; opacity: 0 }
            PropertyChanges { target: cloud6; x: -500; opacity: 0 }
        },
        State {
            name: "fewClouds"
            PropertyChanges { target: sky; color: "#b9d4ee" }
            PropertyChanges { target: cloud1; x: 40; opacity: 1 }
            PropertyChanges { target: cloud2; x: 300; opacity: 0.8 }
            PropertyChanges { target: cloud3; x: -500; opacity: 0 }
            PropertyChanges { target: cloud4; x: -500; opacity: 0 }
            PropertyChanges { target: cloud5; x: -500; opacity: 0 }
            PropertyChanges { target: cloud6; x: -500; opacity: 0 }
        },
        State {
            name: "cloudy"
            PropertyChanges { target: sky; color: "#a0b8cc" }
            PropertyChanges { target: cloud1; x: 40; opacity: 1 }
            PropertyChanges { target: cloud2; x: 300; opacity: 0.4 }
            PropertyChanges { target: cloud3; x: 340; opacity: 1 }
            PropertyChanges { target: cloud4; x: 35; opacity: 0.8 }
            PropertyChanges { target: cloud5; x: 300; opacity: 0 }
            PropertyChanges { target: cloud6; x: -500; opacity: 0 }
        },
        State {
            name: "rainy"
            PropertyChanges { target: sky; color: "#7a96a8" }
            PropertyChanges { target: cloud1; x: 40; opacity: 0.3 }
            PropertyChanges { target: cloud2; x: 350; opacity: 0.4 }
            PropertyChanges { target: cloud3; x: 340; opacity: 1 }
            PropertyChanges { target: cloud4; x: 45; opacity: 0.8 }
            PropertyChanges { target: cloud5; x: 0; opacity: 1}
            PropertyChanges { target: cloud6; x: -500; opacity: 0 }
        },
        State {
            name: "heavyRain"
            PropertyChanges { target: sky; color: "#4c6578" }
            PropertyChanges { target: cloud1; x: 40; opacity: 0 }
            PropertyChanges { target: cloud2; x: 300; opacity: 0.4 }
            PropertyChanges { target: cloud3; x: 340; opacity: 1 }
            PropertyChanges { target: cloud4; x: 35; opacity: 0.8 }
            PropertyChanges { target: cloud5; x: 0; opacity: 1 }
            PropertyChanges { target: cloud6; x: 30; opacity: 1 }
            PropertyChanges { target: cloud7; x: 400; opacity: 1 }

            }
    ]

    // ANIMATIONEN
    transitions: [
        Transition {
            from: "*"
            to: "*"
            ParallelAnimation {
                NumberAnimation { properties: "x,opacity"; duration: 800 }
                ColorAnimation { property: "color"; duration: 800 }
            }
        }
    ]
}
