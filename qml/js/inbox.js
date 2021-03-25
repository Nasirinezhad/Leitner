function boxes(parent)
{
    var component = Qt.createComponent("../components/Box.qml");
    var boxes = l_i.boxes()
    if(parent.children.length > 0 && boxes.length > 0){
        for(var j in parent.children) {
            parent.children[j].destroy()
        }
    }
    for(var i in boxes){
        var el = component.incubateObject(parent, {bid:boxes[i]["id"],
                                              active: boxes[i]["stat"] === 1,
                                              title: boxes[i]["name"],
                                              totalwords: boxes[i]["words"],
                                              details: boxes[i]["descripton"],
                                              btn1Click: download,
                                              btn2Click: remover,
                                              width: parent.parent.width
                                          })
    }
}
function download(item)
{
    if(item.active)
        l_i.deactivate(item.bid)
    else
        l_i.activate(item.bid)
    item.active = !item.active
}
function remover(item)
{
    l_i.removeBox(item.bid)
    item.destroy()
}
