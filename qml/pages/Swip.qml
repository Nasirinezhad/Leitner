import QtQuick 2.12
import QtQuick.Controls 2.12
import '../components'
import '.'
Page {
    title: swipeView.currentItem.title
    SwipeView {
        id: swipeView
        topPadding: 10
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        function boxes_refresh() {boxes.refresh()}
        function changeIndex(i) {
            tabBar.currentIndex = i
        }

        InboxForm {
            id: inbox
            title: "Inbox"
        }
        MyBoxesForm {
            id: boxes
            title: "MyBoxes"
        }
        LeitnersForm {
            id: leitners
            title: "Leitners"
        }
    }

    header: Rectangle {
        id: rectangle
        height: 50
        width: parent.width

        Navigation {
            id: tabBar
            pageIndex: swipeView.currentIndex
            implicitHeight: 50
            width: parent.width
            tabs:[
                NavButton { text: "Inbox"; icon.source: "../assets/Inbox.png" },
                NavButton { text: "MyBoxes"; icon.source: "../assets/Box.png" },
                NavButton { text: "Leitners"; icon.source: "../assets/Cards.png" }
            ]
        }
    }

    Popup {
        id: po_settings
        width: swipeView.width * .9
        height: swipeView.height * .9
        anchors.centerIn: parent
        modal: true
        focus: true
        property alias body: body_.children
        property var props: ({})
        property bool forceopen: false
        closePolicy: (forceopen ? Popup.NoAutoClose : Popup.CloseOnReleaseOutside)
        background:
            Rectangle {
                id: body_
                color: "#FFFFFF"
                radius: 10
                border.width: 0
                anchors.fill: parent

            }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}D{i:8;anchors_height:50}
}
##^##*/
