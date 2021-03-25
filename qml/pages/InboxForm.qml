import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import "../components"
import "../js/inbox.js" as Js
import "."
Page {
    id: page
    Flickable{
        width: parent.width * .9
        height: parent.height-10
        contentHeight: fl.height
        anchors.horizontalCenter: parent.horizontalCenter
        Flow {
            id: fl
            width: parent.width
            spacing: width*.05
            Rectangle {
                id: learning
                color: "transparent"
                width: parent.width *.45
                height: width*1.2
                Image {
                    anchors.fill: parent
                    source: "../assets/Learning.png"
                }
                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 18
                    font.bold: true
                    font.pointSize: 28
                    text: qsTr("Learning")

                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        loader.push(list_c, {i:1, title:qsTr("Learning")})
                    }
                }
            }
            Rectangle {
                id: reviewing
                color: "transparent"
                width: parent.width *.45
                height: width*1.2
                Image {
                    anchors.fill: parent
                    source: "../assets/Reviewing.png"
                }
                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 18
                    font.bold: true
                    font.pointSize: 26
                    text: qsTr("Reviewing")
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        loader.push(list_c, {i:2, title:qsTr("Reviewing")})
                    }
                }
            }
            Rectangle {
                id: passed
                color: "transparent"
                width: parent.width *.45
                height: width*1.2
                Image {
                    anchors.fill: parent
                    source: "../assets/Passed.png"
                }
                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 18
                    font.bold: true
                    font.pointSize: 28
                    text: qsTr("Passed")
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        loader.push(list_c, {i:3, title:qsTr("Passed")})
                    }
                }
            }
            Rectangle {
                id: failed
                color: "transparent"
                width: parent.width *.45
                height: width*1.2
                Image {
                    anchors.fill: parent
                    source: "../assets/Failed.png"
                }
                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 18
                    font.bold: true
                    font.pointSize: 28
                    text: qsTr("Failed")
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        loader.push(list_c, {i:4, title:qsTr("Failed")})
                    }
                }
            }
        }
    }

    RoundButton {
        id: rbutt
        padding: 15
        icon.source: "../assets/arrow.png"
        scale: 0.8
        highlighted: true
        anchors.margins: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        icon.color: "#FFFFFF"
        background: Rectangle {
            color: "#00B193"
            radius: width*.5
        }

        onClicked: {
            loader.push(review_c)
        }
    }
    DropShadow {
        anchors.fill: rbutt
        samples: 17
        color: "#80000000"
        source: rbutt
        cached: true
    }

    Component {
        id: list_c
        MList {
            id: list
        }
    }
    Component {
        id: review_c
        Review {
            id: reviw
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
