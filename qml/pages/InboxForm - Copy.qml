import QtQuick 2.12
import QtQuick.Controls 2.5
import "../components"
import "../js/inbox.js" as Js

Page {
    Flickable{
        id: page
        width: parent.width * .9
        height: parent.height-10
        contentHeight: col.height
        anchors.horizontalCenter: parent.horizontalCenter
        Column {
            id: col
            Part {
                id: pA
                width: page.width
                childClick: Js.showmodal
                title: "Part A, Learning"
            }
            Part {
                id: pB
                width: page.width
                childClick: Js.showmodal
                title: "Part B, Reviewing"
                property int part: 2
            }
            Part {
                id: pC
                width: page.width
                childClick: Js.showmodal
                title: "Part C, Passed"
                property int part: 3
            }
            Part {
                id: pD
                width: page.width
                childClick: Js.showmodal
                title: "Part D, Failed"
            }
        }
    }
    Popup {
        id: po_word
        width: parent.width * .9
        height: parent.height * .9
        anchors.centerIn: parent

        modal: true
        focus: true
        property int wid: 0
        property string word: "-"
        property string trans: "-"
        property string desc: "-"
        property int part: 1
        background: Rectangle {
            id: rectangle
            color: "#FFFFFF"
            radius: 10
            border.width: 0
            anchors.fill: parent
            Text {
                id: word
                text: po_word.word
                property int pf: parent.width / po_word.word.length
                height: parent.height * 0.2
                font.pixelSize: pf > height ? height : pf
                font.bold: true
                anchors.top: parent.top
                bottomPadding: 5
                topPadding: 5
                padding: 10
            }
            Text {
                id: trans
                text: po_word.trans
                anchors.right: parent.right
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignRight
                font.bold: true
                font.pixelSize: parent.width / (po_word.trans.length + 5)
                anchors.top: word.bottom
                bottomPadding: 5
                topPadding: 5
                padding: 10
            }
            Text {
                id: desc
                text: po_word.desc
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.bottom: buttonBox.top
                anchors.top: trans.bottom
                font.pixelSize: parent.width * .035
                color: "#4a4a4a"
                bottomPadding: 5
                topPadding: 5
                padding: 10
            }
            Row {
                id: buttonBox
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                Button {
                    id: moveA
                    height: 26
                    text: "move to A"
                    width: parent.width /3
                    onClicked: {
                        if(po_word.part!=1){
                            l_i.move(po_word.wid, 1)
                            po_word.part = 1
                        }
                    }

                    contentItem: Rectangle {
                        anchors.fill: parent
                        color: (po_word.part==1 ? "#7ab8a9" : "#00C193")
                        Text {
                            text: moveA.text
                            fontSizeMode: Text.Fit
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#FFFFFF"

                        }
                    }
                }
                Button {
                    id: moveB
                    height: 26
                    text: "move to B"
                    width: parent.width /3
                    onClicked: {
                        if(po_word.part!=2){
                            l_i.move(po_word.wid, 2)
                            po_word.part = 2
                        }
                    }

                    contentItem: Rectangle {
                        anchors.fill: parent
                        color: (po_word.part==2 ? "#7ab8a9" : "#00C193")
                        Text {
                            text: moveB.text
                            fontSizeMode: Text.Fit
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#FFFFFF"

                        }
                    }
                }
                Button {
                    id: moveC
                    height: 26
                    text: "move to C"
                    width: parent.width /3
                    onClicked: {
                        if(po_word.part!=3){
                            l_i.move(po_word.wid, 3)
                            po_word.part = 3
                        }
                    }

                    contentItem: Rectangle {
                        anchors.fill: parent
                        color: (po_word.part==3 ? "#7ab8a9" : "#00C193")
                        Text {
                            text: moveC.text
                            fontSizeMode: Text.Fit
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#FFFFFF"

                        }
                    }
                }
            }
        }
    }
    Component.onCompleted:{
        Js.part(pA.contents,1)
        Js.part(pB.contents,2)
        Js.part(pC.contents,3)
        Js.part(pD.contents,4)
    }

    Connections {
        target: l_i
        function onChanges(pa) {
            if(pa===1){
                Js.part(pA.contents,1)
                Js.part(pB.contents,2)
                pA.opened = false
                pB.opened = false
            }else if(pa===2){
                Js.part(pB.contents,2)
                Js.part(pC.contents,3)
                pC.opened = false
                pB.opened = false
            }else if(pa === 3){
                Js.part(pC.contents,3)
                Js.part(pD.contents,4)
                pC.opened = false
                pD.opened = false
            }else{
                Js.part(pA.contents,1)
                Js.part(pB.contents,2)
                Js.part(pC.contents,3)
                Js.part(pD.contents,4)
                pA.opened = false
                pB.opened = false
                pC.opened = false
                pD.opened = false
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}
}
##^##*/

