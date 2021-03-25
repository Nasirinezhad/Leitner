import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: itm
    property alias contents: body
    property var childClick: ({})
    property string title: "Part"
    property bool opened: false
    height: opened ? body.height + 40 : 35
    Behavior on height {
        SpringAnimation {
            spring: 3
            damping: 0.3
        }
    }
    Rectangle {
        id: rectangle
        anchors.fill: parent
        Rectangle {
            id: head
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 30
            radius: 3
            color: "#FFFFFF"
            Text {
                text: title
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }
            Image {
                id: icon
                width: 16
                height: 16
                rotation: opened ? 180 : 0
                Behavior on rotation {
                    SpringAnimation {
                        spring: 3
                        damping: 0.3
                    }
                }
                source: "../assets/arrow.png"
                scale: 0.6
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    opened = !opened
                }
            }
        }

        DropShadow {
            anchors.fill: head
            samples: 17
            color: "#80000000"
            source: head
            cached: true
        }
        Rectangle {
            id: bodybg
            height: itm.height-35
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: head.bottom
            radius: 3
            color: "#FFFFFF"
            visible: body.visible
        }
        DropShadow {
            anchors.fill: bodybg
            samples: 17
            color: "#80000000"
            source: bodybg
            cached: true
        }
        Flow {
            id: body
            property alias childClick: itm.childClick
            visible: itm.height-30 >= height
            anchors.top: head.bottom
            width: parent.width
            spacing: 10
            padding: 10
            z: 9
        }
    }
}

