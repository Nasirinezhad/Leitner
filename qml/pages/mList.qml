import QtQuick 2.12
import QtQuick.Controls 2.12
import '../components'

Page {
    id: page
    property int i: 0
    padding: width*.03
    ListView {
        id: listView

        signal pressAndHold(int index)
        focus: true
        boundsBehavior: Flickable.StopAtBounds
        anchors.fill: parent


        delegate: Word {
            width: listView.width
        }
        model: l_i.part(i)
    }
    Label {
        id: nothing
        color: "#8a8a8a"
        text: qsTr("No Word :(")
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 28
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Component.onCompleted: {
            if(listView.count > 0){
                nothing.visible = false
            }
    }
}
