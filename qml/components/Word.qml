
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

ItemDelegate {
    id: delegate
    checkable: true

    contentItem: Column {
        spacing: 10
        Row {
            id: ro
            width: delegate.width
            spacing: 5
            Label {
                width: parent.width*.5
                text: modelData.word
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
            Label {
                text: modelData.translate
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }
        Text {
            id: desc
            width: delegate.width-5
            visible: false
            text: modelData.descripton
            wrapMode: Text.WordWrap
        }
    }
    Rectangle {
        height: 1
        width: parent.width
        anchors.bottom: parent.bottom
        color: "#BBB"
    }

    states: [
        State {
            name: "expanded"
            when: delegate.checked

            PropertyChanges {
                target: desc
                visible: true
            }
        }
    ]
}
