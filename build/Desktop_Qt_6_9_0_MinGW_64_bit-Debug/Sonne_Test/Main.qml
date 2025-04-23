import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Sonne"

    Sonnenstand {
        anchors.fill: parent
        z: 0
    }
}
