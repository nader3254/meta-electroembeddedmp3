import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.0


ApplicationWindow
{
    visible: true
    width: 800
    height: 480
    title: qsTr("electroembedded mp3")

    Rectangle{
        anchors.fill: parent
        color: "black"
        gradient: Gradient {
                GradientStop { position: 0.0; color: "#551133" }
                GradientStop { position: 1.0; color: "black" }
            }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        onAccepted: {
            Mp3Backend.setWorkingDir(fileDialog.folder);
            let x= Mp3Backend.getFiles();
            let y= Mp3Backend.getArtists();
            let z= Mp3Backend.getCovers();
            for(let i in x)
            {
                myplaylist.insterPlayList(x[i],y[i],z[i])

            }
        }
        onRejected: {
            console.log("Canceled")
        }
    }
        Row{
            width: parent.width
            height: parent.height
            Sidebar{

            }
            Playlist{
                id:myplaylist
                visible: false

            }
            Rectangle{
                id:youtubePage
                visible: false
                anchors.fill:parent
                color: "black"
                Text {
                    id: name
                    text: qsTr("Youtube")
                    anchors.centerIn: parent
                    color: "white"
                }
            }
            Rectangle{
                id:soundcloudPage
                visible: false
                anchors.fill:parent
                color: "black"
                Text {
                    id: name2
                    text: qsTr("soundCloud")
                    anchors.centerIn: parent
                    color: "white"
                }

            }
            StackView {
                id: mystack
                initialItem: myplaylist
                height: parent.height
                width: parent.width -( parent.width/10*2.5)

                pushEnter: Transition
                          {
                            ParallelAnimation
                            {
                              NumberAnimation { property: "opacity";from: 0; to: 1.0; duration: 800 }
//                              NumberAnimation { property: "scale";from: 0; to:1.0; duration: 300 }
                            }
                          }
            }
        }
        Footer{

            sname: myplaylist.songname
        }
}



//import QtQuick 2.4
//import QtQuick.Window 2.2

//Window {
//    visible: true
//    width: 1280
//    height: 800
//    MouseArea {
//        //the mouse events will be replaced with c++ events later
//        anchors.fill: parent
//        onWheel: {
//            if (wheel.angleDelta.y < 0)
//            {
//                if (scrollViewAnimation.running) {
//                    scrollViewAnimation.stop()
//                    scrollViewAnimation.to--
//                    scrollViewAnimation.start()
//                }
//                else {
//                    scrollViewAnimation.to = Math.round(view.offset - 1)
//                    scrollViewAnimation.start()
//                }
//            }
//            else if (wheel.angleDelta.y > 0)
//            {
//                if (scrollViewAnimation.running) {
//                    scrollViewAnimation.stop()
//                    scrollViewAnimation.to++
//                    scrollViewAnimation.start()
//                }
//                else {
//                    scrollViewAnimation.to = Math.round(view.offset + 1)
//                    scrollViewAnimation.start()
//                }
//            }
//        }
//    }

//    PathView {
//        id: view
//        property int itemAngle: 45.0
//        property int itemSize: width/3.5

//        anchors.fill: parent
//        pathItemCount: 10
//        preferredHighlightBegin: 0.5
//        preferredHighlightEnd: 0.5
//        interactive: true
//        model: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
//        delegate: viewDelegate

//        onDragStarted: {
//            scrollViewAnimation.stop()
//        }

//        NumberAnimation on offset {
//            id: scrollViewAnimation
//            duration: 2500
//            easing.type: Easing.InCurve
//        }

//        path: Path {
//            startX: 0
//            startY: height / 2
//            PathPercent { value: 0.0 }
//            PathAttribute { name: "z"; value: 0 }
//            PathAttribute { name: "angle"; value: view.itemAngle }
//            PathAttribute { name: "origin"; value: 0 }


//            PathLine {x: view.width*0.4; y: view.height / 2}
//            PathPercent { value: 0.45 }
//            PathAttribute { name: "angle"; value: view.itemAngle }
//            PathAttribute { name: "origin"; value: 0 }
//            PathAttribute { name: "z"; value: 10 }


//            PathLine { relativeX: 0; relativeY: 0 }
//            PathAttribute { name: "angle"; value: 0.0 }
//            PathAttribute { name: "origin"; value: 0 }
//            PathAttribute { name: "z"; value: 10 }


//            PathLine {x: view.width*0.6; y: view.height / 2}
//            PathPercent { value: 0.55 }
//            PathAttribute { name: "angle"; value: 0.0 }
//            PathAttribute { name: "origin"; value: 0 }
//            PathAttribute { name: "z"; value: 10 }


//            PathLine { relativeX: 0; relativeY: 0 }
//            PathAttribute { name: "angle"; value: -view.itemAngle }
//            PathAttribute { name: "origin"; value: view.itemSize }
//            PathAttribute { name: "z"; value: 10 }


//            PathLine {x: view.width; y: view.height / 2}
//            PathPercent { value: 1 }
//            PathAttribute { name: "angle"; value: -view.itemAngle }
//            PathAttribute { name: "origin"; value: view.itemSize }
//            PathAttribute { name: "z"; value: 0 }
//        }
//    }

//    Component {
//        id: viewDelegate
//        Rectangle {
//            id: flipItem
//            width: view.itemSize
//            height: view.height
//            color: "white"
//            z: PathView.z

//            property var rotationAngle: PathView.angle
//            property var rotationOrigin: PathView.origin

//            transform:
//                Rotation {
//                id: rot
//                axis { x: 0; y: 1; z: 0 }
//                angle: rotationAngle
//                origin.x: rotationOrigin
//                origin.y: width
//            }


//            Rectangle {
//                border.color: "black"
//                border.width: 2
//                color: (index%2 === 0) ? "yellow" : "royalblue"
//                anchors.top: flipItem.top
//                anchors.topMargin: 100
//                anchors.left: flipItem.left
//                anchors.right: flipItem.right
//                width: flipItem.width
//                height: flipItem.height*0.55
//                smooth: true
//                antialiasing: true
//                Text {
//                    text: model.modelData
//                    color: "gray"
//                    font.pixelSize: 30
//                    font.bold: true
//                    anchors.centerIn: parent
//                }
//            }
//        }
//    }
//}









//import QtQuick 2.13
//import QtQuick.Window 2.13
//import QtQuick.Controls 1.4

//ApplicationWindow {
//    visible: true
//    width: 800
//    height: 480
//    title: qsTr("HelloMp3")

//    Row{
//        width: parent.width
//        height: parent.height
//        Sidebar{

//        }
//        Playlist{
//            id:myplaylist

//        }
//    }

//    Footer{
//        duration: myplaylist.currentDuration
//        val:myplaylist.currentProgress
//    }

//}
