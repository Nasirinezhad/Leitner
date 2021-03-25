import QtQuick 2.12
import QtQuick.Controls 2.5
import "../components"
import "../js/inbox.js" as Js

Page {
    function refresh(){Js.boxes(boxes)}
    Flickable{
        id: page
        width: parent.width * .9
        height: parent.height-10
        contentHeight: boxes.height
        anchors.horizontalCenter: parent.horizontalCenter
        Column {
            id: boxes
            spacing: 5
        }
    }
    Component.onCompleted: {
        Js.boxes(boxes)
    }
}
