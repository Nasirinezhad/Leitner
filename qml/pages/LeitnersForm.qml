import QtQuick 2.12
import QtQuick.Controls 2.5
import "../components"

Page {
    property var l_ins: l_i.boxesNames()
    Flickable{
        id: page
        width: parent.width * .9
        height: parent.height-10
        contentHeight: col.height
        anchors.horizontalCenter: parent.horizontalCenter
        Column {
            id: col
            spacing: 10
            Box {
                visible: l_ins["1A"] === undefined
                width: page.width
                title: "Eight 1A"
                totalwords: "470"
                details: "Eight, which suits an eight level English course of young adult and adult learning covers the basic to advanced level of English language proficiency. Adopting a fairly structured communicative approach and employing a wide range of different activitiesm it intends to helpl learners bridge to gap between the classroom and the real world."
                online: true
                btn1Click: ()=>{
                    l_i.download("http://leitner.jdghayenat.ir/1A")
                    po_leitners.open()
                }
            }
            Box {
                visible: l_ins["1B"] === undefined
                width: page.width
                title: "Eight 1B"
                totalwords: "???"
                details: "Eight, which suits an eight level English course of young adult and adult learning covers the basic to advanced level of English language proficiency. Adopting a fairly structured communicative approach and employing a wide range of different activitiesm it intends to helpl learners bridge to gap between the classroom and the real world."
                online: true

                btn1Click: ()=>{
                    l_i.download("http://leitner.jdghayenat.ir/1B")
                    po_leitners.open()
                }
            }
            Box {
                visible: l_ins["2A"] === undefined
                width: page.width
                title: "Eight 2A"
                totalwords: "???"
                details: "Eight, which suits an eight level English course of young adult and adult learning covers the basic to advanced level of English language proficiency. Adopting a fairly structured communicative approach and employing a wide range of different activitiesm it intends to helpl learners bridge to gap between the classroom and the real world."
                online: true
                btn1Click: ()=>{
                    l_i.download("http://leitner.jdghayenat.ir/2A")
                    po_leitners.open()
                }
            }
            Box {
                visible: l_ins["2B"] === undefined
                width: page.width
                title: "Eight 2B"
                totalwords: "???"
                details: "Eight, which suits an eight level English course of young adult and adult learning covers the basic to advanced level of English language proficiency. Adopting a fairly structured communicative approach and employing a wide range of different activitiesm it intends to helpl learners bridge to gap between the classroom and the real world."
                online: true
                btn1Click: ()=>{
                    l_i.download("http://leitner.jdghayenat.ir/2B")
                    po_leitners.open()
                }
            }
            Box {
                visible: l_ins["3A"] === undefined
                width: page.width
                title: "Eight 3A"
                totalwords: "???"
                details: "Eight, which suits an eight level English course of young adult and adult learning covers the basic to advanced level of English language proficiency. Adopting a fairly structured communicative approach and employing a wide range of different activitiesm it intends to helpl learners bridge to gap between the classroom and the real world."
                online: true
                btn1Click: ()=>{
                    l_i.download("http://leitner.jdghayenat.ir/3A")
                    po_leitners.open()
                }
            }
            Box {
                visible: l_ins["3B"] === undefined
                width: page.width
                title: "Eight 3B"
                totalwords: "???"
                details: "Eight, which suits an eight level English course of young adult and adult learning covers the basic to advanced level of English language proficiency. Adopting a fairly structured communicative approach and employing a wide range of different activitiesm it intends to helpl learners bridge to gap between the classroom and the real world."
                online: true
                btn1Click: ()=>{
                    l_i.download("http://leitner.jdghayenat.ir/3B")
                    po_leitners.open()
                }
            }
        }
    }
    Connections {
        target: l_i
        function onNewbox(pc, stat){
            switch(stat){
            case 1:
                if(pc === 1){
                    po_leitners.text = "Downloaded"
                }else{
                    po_leitners.text = "Downloading..."
                    po_leitners.percent = pc/2
                }
                break;
            case 2:
                if(pc === 1){
                    po_leitners.text = "Installed"
                    po_leitners.percent += 0.2
                }else{
                    po_leitners.text = "Installing..."
                    po_leitners.percent += 0.1
                }
                break;
            case 3:
                if(pc === 1){
                    po_leitners.text = "Installed"
                    po_leitners.percent = 1;
                }else{
                    po_leitners.text = "Failed"
                    po_leitners.color = "#BC0C52"
                    po_leitners.percent = 1;
                }
                break;
            }
        }
    }

    Popup {
        id: po_leitners
        width: parent.width * .9
        height: parent.height * .3
        anchors.centerIn: parent
        modal: true
        focus: true
        property int lid: 0
        property int percent: 0
        property alias text: status.text
        property alias color: progressBar.color
        closePolicy: (percent < 1 ? po_leitners.NoAutoClose : po_leitners.CloseOnReleaseOutside)
        background: Rectangle {
            id: body
            color: "#FFFFFF"
            radius: 10
            border.width: 0
            anchors.fill: parent
            Text {
                id: status
                color: "#595959"
                text:  "Connecting..."
                font.pointSize: 20
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 25
                horizontalAlignment: Text.AlignHCenter


            }

            ProgressLine {
                id: progressBar
                anchors.top: status.bottom
                height: 5
                width: parent.width*0.8
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Control {
                    id: control
                    width: po_leitners.percent
                }
            }
        }
        onClosed: {
            swipeView.changeIndex(1)
            swipeView.boxes_refresh()
            lid= 0
            percent= 0
            l_ins= l_i.boxesNames()
        }
    }
}

