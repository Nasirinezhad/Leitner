import QtQuick 2.12
import QtQuick.Controls 2.12
import '../components'

Item {
    signal done()
    property alias running: animate.running
    property string title: ""
    Row {
        id: logo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Text {
            text: qsTr("Le")
            color: "#606060"
            font.pointSize: 64
        }
        Text {
            text: qsTr("i")
            color: "#00C193"
            font.pointSize: 64
        }
        Text {
            text: qsTr("tner")
            color: "#606060"
            font.pointSize: 64
        }
    }
    ProgressLine {
        id: progressBar
        anchors.top: logo.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: logo.width * .8
        height: 5
        Control {
            id: control
            SpringAnimation {
                id:animate
                spring: 1
                damping: 0.3
                target: control
                property: "width"
                duration: 2000
                easing.type: Easing.InOutQuad
                from: 0
                to: 1
                running: true
                onFinished: done()
            }
        }
    }
}
