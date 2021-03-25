import QtQuick 2.12
import QtQuick.Controls 2.12
import 'pages'

ApplicationWindow {
    id: applicationWindow
    visible: true

    header: ToolBar {
        id: app_header
        contentHeight: toolButton.implicitHeight
        background: Rectangle{
            color: "#00B193"
        }
        visible: false
        rightPadding: 5
        leftPadding: 5
        bottomPadding: 10
        topPadding: 10
        Button {
            id: toolButton
            visible: loader.depth > 2
            scale: 0.8
            icon.source: "assets/arrow.png"
            rotation: 180
            icon.color: "#FFFFFF"
            font.pointSize: 10
            onClicked: {
                loader.pop()
            }
            background: Rectangle {
                color: "transparent"
            }
        }

        Label {
            text: loader.currentItem.title
            font.bold: true
            anchors.centerIn: parent
            color: "#FFFFFF"

        }

        Button {
            id: button
            font.bold: true
            font.pointSize: 12
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 5
            icon.source: "assets/menu.png"
            icon.color: "#FFFFFF"
            background: Rectangle {
                color: "transparent"
            }
            onClicked: {
                po_settings.open()
            }
        }
    }
    StackView {
        id: loader
        anchors.fill: parent
        initialItem: splash
        pushEnter: Transition {
                  PropertyAnimation{
                      property: "opacity"
                      from: 0
                      to: 1
                      duration: 300
                  }
              }
        popExit: Transition {
            PropertyAnimation{
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }
        }
    }

    Component {
        id: splash
        Splash {
            onDone: {
                     loader.pop()
                     loader.push(swip_cmp)
                     app_header.visible= true
                 }
        }
    }
    Component {
        id: swip_cmp
        Swip {

        }
    }

    Component.onCompleted: l_i.run()
}
