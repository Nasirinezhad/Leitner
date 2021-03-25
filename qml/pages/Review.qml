import QtQuick 2.12
import QtQuick.Controls 2.12
import '../components'

Page {
    id: page
    property var word: l_i.getword()
    padding: width*.03

    Label {
        id: label
        text: (word["ok"] ? word["word"] : qsTr("Nothing to learn!"))
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottomMargin: 0
        padding: 15
        font.bold: true
        font.pointSize: 22
    }

    Label {
        id: remd
        text: (word["ok"] ? (word["part"] == 1 ? word["translate"] : "Did you remember?"): qsTr("You should to go to leitners and download a box"))
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: label.bottom
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        padding: 15
    }

    Label {
        id: remm
        text: (word["ok"] ? (word["part"] == 1 ? word["descripton"] : "..."): qsTr("..."))
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: remd.bottom
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        padding: 15
    }

    Button {
        id: butn
        text: (word["ok"] ? (word["part"] == 1 ? "Next" : "Show me") : qsTr("..."))
        anchors.left: remm.left
        height: 38
        anchors.right: remm.right
        anchors.top: remm.bottom
        anchors.leftMargin: 0
        property string color: "#0093C1"
        contentItem: Rectangle {
            id: rectangle1
            anchors.fill: parent
            color: butn.color
            radius: 3
            Text {
                text: butn.text
                fontSizeMode: Text.Fit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "#FFFFFF"

            }
        }
        onClicked: {
            if(word["ok"]){
                if(word["part"] == 1)
                {
                    l_i.move(word["id"], "2")
                    word = l_i.getword()
                }else{
                    po_review.open()
                }
            }else{
                l_i.getword()
                swipeView.changeIndex(2)
                loader.pop()
            }
        }
    }

    Popup {
        id: po_review
        width: parent.width * .9
        height: parent.height * .3
        anchors.centerIn: parent
        modal: true
        focus: true
        closePolicy: po_leitners.NoAutoClose
        background: Rectangle {
            id: body
            color: "#FFFFFF"
            radius: 10
            border.width: 0
            anchors.fill: parent
            Label {
                id: trans
                color: "#595959"
                text:  (word["ok"] ? word["translate"] : "!")
                font.pointSize: 20
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 25
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                id: gsd
                color: "#595959"
                text:  "Did you guess correctly?"
                anchors.right: trans.right
                anchors.left: trans.left
                anchors.top: trans.bottom
                horizontalAlignment: Text.AlignHCenter
                padding: 15

            }

            Button {
                id: btn_yes
                text: (word["ok"] ? "Yes" : "!")
                anchors.right: gsd.right
                anchors.rightMargin: 5
                height: 28
                width: po_review.width *.3
                anchors.top: gsd.bottom
                anchors.topMargin: 5
                contentItem: Rectangle {
                    id: rec_yes
                    anchors.fill: parent
                    color: "#00C193"
                    radius: 3
                    Text {
                        text: btn_yes.text
                        fontSizeMode: Text.Fit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#FFFFFF"

                    }
                }
                onClicked: {
                    l_i.move(word["id"], "3")
                    po_review.close()
                }
            }
            Button {
                id: btn_no
                text: (word["ok"] ? "No" : "!")
                anchors.left: gsd.left
                anchors.leftMargin: 5
                height: 28
                width: po_review.width *.3
                anchors.top: gsd.bottom
                anchors.topMargin: 5
                contentItem: Rectangle {
                    id: rec_no
                    anchors.fill: parent
                    color: "#BC0C52"
                    radius: 3
                    Text {
                        text: btn_no.text
                        fontSizeMode: Text.Fit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#FFFFFF"
                    }
                }
                onClicked: {
                    l_i.move(word["id"], "4")
                    po_review.close()
                }
            }
        }
        onClosed: {
            word = l_i.getword()
        }
    }
}

