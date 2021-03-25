import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    clip: true
    property alias color: bar.color
    Rectangle {
        id: progressBar
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height
        color: "#909090"
        Row {
            anchors.fill: parent
            Rectangle {
                id: bar
                color: "#00C193"
                width: control.width * parent.width
                height: parent.height

            }
        }
    }
}
