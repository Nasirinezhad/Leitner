import QtQuick 2.12
import QtQuick.Controls 2.12


Rectangle {
    id: tabBar
    property alias tabs: row.children
    property int currentIndex: 0
    property int pageIndex: 0

    width: parent.width
    height: 50
    color: "#00C193"
    Row {
        id: row
        property int total: parent.tabs.length-1
        function index(i){
            tabBar.currentIndex = i
        }

        anchors.fill: parent
    }

    Rectangle{
        width: parent.width / parent.tabs.length
        anchors.bottom: parent.bottom
        height: 5
        color: "#FFFFFF"
        x: width * tabBar.pageIndex
        z: 9
        Behavior on x {
            SpringAnimation {
                spring: 3
                damping: 0.3
            }
        }
        onXChanged: {
            tabBar.currentIndex = tabBar.pageIndex
        }
    }
}
