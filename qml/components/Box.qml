import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
Item {
    id: item2
    property int bid: 0
    property string title: "title"
    property string totalwords: "totalwords"
    property string details: "details"
    property bool online: false
    property bool active: false
    property var btn1Click: ({})
    property var btn2Click: ({})

    width: parent.width
    height: head.contentHeight+det.contentHeight + 50
    Rectangle {
        id: bodybg
        anchors.fill: parent
        radius: 4
        color: "#FFFFFF"
        Text {
            id: head
            color: "#373737"
            text: title
            font.bold: true
            font.pointSize: 14
            anchors.leftMargin: 5
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.top: parent.top
        }
        Text {
            id: tw
            color: "#777777"
            text: totalwords
            font.bold: true
            font.pointSize: 10
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
        }
        Rectangle {
            id: hr
            width: parent.width * .9
            height: 1
            color: "#707070"
            anchors.top: head.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: det
            width: parent.width
            color: "#222222"
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: details
            anchors.margins: 5
            anchors.top: hr.bottom
            anchors.right: parent.right
            anchors.left: parent.left
        }
        Button {
            id: add
            width: 72
            height: 26
            text: online ? "Download" : (active ? "Deactive" : "Active")

            anchors.right: parent.right
            anchors.top: det.bottom
            anchors.rightMargin: 5
            anchors.bottomMargin: 5
            onClicked: {btn1Click(item2)}
            contentItem: Rectangle {
                id: rectangle
                anchors.fill: parent
                color: (active ? "#BC0C52" : "#00C193")
                radius: 3
                Text {
                    text: add.text
                    fontSizeMode: Text.Fit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#FFFFFF"

                }
            }
        }
        Text {
            id: delt
            visible: !online
            color: "#BC0C52"
            text: "Delete"
            anchors.verticalCenter: add.verticalCenter
            anchors.right: add.left
            anchors.rightMargin: 10
            font.underline: true
            MouseArea {
                anchors.fill: parent
                onClicked: {btn2Click(item2)}
            }
        }
    }

    DropShadow {
        anchors.fill: bodybg
        samples: 17
        color: "#80000000"
        source: bodybg
        cached: true
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}D{i:5;anchors_width:630}
}
##^##*/
