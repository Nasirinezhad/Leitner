import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
                id: control
                width: parent.width / (parent.parent.tabs.length)
                height: parent.height -15
                anchors.top: parent.top
                property int index: 0
                onClicked: {
                    parent.index(index)
                }
                Component.onCompleted: {
                    index = parent.total
                    parent.total --
                }

                contentItem: Rectangle {
                    id: rectangle
                    anchors.fill: parent
                    color: "#00C193"
                    Image {
                            id: img
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: control.icon.source
                            width: control.icon.width
                            height: control.icon.height
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: img.bottom
                            text: control.text
                            font.pointSize: 9
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            color: "#FFFFFF"
                        }

                }

            }

