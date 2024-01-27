import QtQuick 2.13
import QtGraphicalEffects 1.15
import QtMultimedia 5.15
import QtQuick.Controls.Material 2.4
import QtQuick.Particles 2.0



/*
[
                       Rotation {
                           axis { x: 0; y: 0; z: 1 }
                           angle: 45
                           origin.x: 150
                           origin.y: 150
                       },
                       Scale {
                           xScale: 0.5773
                           yScale: 1.0
                       },
                       Rotation {
                           axis { x: 0; y: 0; z: 1 }
                           angle: -30
                       }
                   ]

*/

Rectangle{
    id:root
    width:  parent.width
    height: parent.height
    anchors.centerIn: parent
    color: "transparent"

    Gradient {
            id:backtheme
                GradientStop { position: 0.0; color: "#551133"}
                GradientStop { position: 1.0; color: "black" }
         }
    property int currIdx: 0
    property string backimg: ""
    property string songname: ""

    function next(){
        currIdx++;
        console.log(songs.get(currIdx).name)
        view.incrementCurrentIndex();

        if((songs.get(currIdx).img)==="qrc:/music-note.png")
        {
            backimg="";
        }
        else
        {
            backimg=(songs.get(currIdx).img)===undefined?"":(songs.get(currIdx).img);
        }
        songname=songs.get(currIdx).name
        Mp3Backend.setSong(songs.get(currIdx).name);
        Mp3Backend.play();
    }
    function previous(){
        currIdx--;
        console.log(currIdx)
        console.log(songs.get(currIdx).name)
        view.decrementCurrentIndex();

        if((songs.get(currIdx).img)==="qrc:/music-note.png")
        {
            backimg="";
        }
        else
        {
            backimg=(songs.get(currIdx).img)===undefined?"":(songs.get(currIdx).img);
        }
         songname=songs.get(currIdx).name
        Mp3Backend.setSong(songs.get(currIdx).name);
        Mp3Backend.play();
    }
    function play(){
        Mp3Backend.play();
    }
    function pause(){
        Mp3Backend.pause();
    }

    function insterPlayList(a,b,c){
        songs.append({
            name:a,
            artist:b,
            img:c
        });
    }



    Image {
        id: background
        opacity: (backimg=="")?0:1
        anchors.fill: parent
        source: backimg
        Rectangle{
            anchors.fill: parent
            color: "black"
            opacity: (backimg=="")?0:0.4
        }
        OpacityAnimator on opacity{
                from: 0;
                to: 1;
                duration: 5000
                running: true

        }
        OpacityAnimator on opacity{
                from: 1;
                to: 0;
                duration: 5000
                running: true
        }
    }
    GaussianBlur {
        anchors.fill: background
        source: background
        radius: 20
        samples: 16
    }


    ListModel {
        id:songs
    }


        PathView {
            id: view
            property int itemAngle: 60.0
            property int itemSize: width/3.5
            width: parent.width-100
            height: parent.height

            anchors.right: parent.right
            anchors.rightMargin:20

//            anchors.centerIn: parent
            pathItemCount: 11
            preferredHighlightBegin: 0.5
            preferredHighlightEnd: 0.5
            interactive: true
            model: songs
            delegate: viewDelegate

            onDragStarted: {
                scrollViewAnimation.stop()
            }

            NumberAnimation on offset {
                id: scrollViewAnimation
                duration: 3000
                easing.type: Easing.InBack
            }

            path: Path {
                startX: 0
                startY: height / 2
                PathPercent { value: 0.0 }
                PathAttribute { name: "z"; value: 0 }
                PathAttribute { name: "angle"; value: view.itemAngle }
                PathAttribute { name: "origin"; value: 0 }


                PathLine {x: view.width*0.4; y: view.height / 2}
                PathPercent { value: 0.45 }
                PathAttribute { name: "angle"; value: view.itemAngle }
                PathAttribute { name: "origin"; value: 0 }
                PathAttribute { name: "z"; value: 10 }


                PathLine { relativeX: 0; relativeY: 0 }
                PathAttribute { name: "angle"; value: 0.0 }
                PathAttribute { name: "origin"; value: 0 }
                PathAttribute { name: "z"; value: 10 }


                PathLine {x: view.width*0.6; y: view.height / 2}
                PathPercent { value: 0.55 }
                PathAttribute { name: "angle"; value: 0.0 }
                PathAttribute { name: "origin"; value: 0 }
                PathAttribute { name: "z"; value: 10 }


                PathLine { relativeX: 0; relativeY: 0 }
                PathAttribute { name: "angle"; value: -view.itemAngle }
                PathAttribute { name: "origin"; value: view.itemSize }
                PathAttribute { name: "z"; value: 10 }


                PathLine {x: view.width; y: view.height / 2}
                PathPercent { value: 1 }
                PathAttribute { name: "angle"; value: -view.itemAngle }
                PathAttribute { name: "origin"; value: view.itemSize }
                PathAttribute { name: "z"; value: 0 }
            }
        }

        Component {
            id: viewDelegate

            Rectangle {
                id: flipItem
                width: view.itemSize
                height: view.height
                color: "transparent"
                z: PathView.z


                property var rotationAngle: PathView.angle
                property var rotationOrigin: PathView.origin

                transform:Rotation {
                    id: rot
                    axis { x: 0; y: 1; z: 0 }
                    angle: rotationAngle
                    origin.x: rotationOrigin
                    origin.y: width
                }

                Rectangle {
                    id: item
                    y:100
                    height: parent.height* 0.45
                    width: parent.width

                    radius:10
                    border.width: 1
                    border.color: "#ffffff"
                    color: "transparent"

                    Rectangle{
                        anchors.fill: parent
                        color: "black"
                        opacity: 0.2
                    }

                    Image {
                        width: parent.width-10
                        height: parent.height-25
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        scale: 0.8
                        source: ((songs.get(index).img)===undefined)?"qrc:/music-note.png":(songs.get(index).img)
                    }
                    Text {
                        id: name
                        anchors.top: parent.bottom
                        anchors.topMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: (parent.width/2)-(name.width/2)
                        color: "#ffffff"
                        font.pixelSize: 10
                        opacity: (index===view.currentIndex)?1:0.3
                        text: qsTr(songs.get(index).name)
                    }
                    MouseArea
                    {
                        anchors.fill:parent
                        onClicked:
                        {
                            if(index>currIdx){
                                for(let i=currIdx;i<index;i++)
                                {
                                    view.incrementCurrentIndex();

                                }
                            }
                            else{
                                for(let i=index;i<currIdx;i++)
                                {
                                   view.decrementCurrentIndex();
                                }
                            }


                            currIdx=index
                            if((songs.get(index).img)==="qrc:/music-note.png")
                            {
                                backimg="";
                            }
                            else
                            {
                                backimg=(songs.get(index).img)===undefined?"":(songs.get(index).img);
                            }
                            songname=songs.get(currIdx).name

                            // here should use the backend to play the mp3
                            Mp3Backend.setSong(songs.get(index).name);
                            Mp3Backend.play();
                        }
                    }
                }
            }
        }

        Item {
            anchors.fill: parent
            visible: (songs.count>=1)?false:true
            Rectangle {
                color: "transparent"
                anchors.fill: parent
            }

            ParticleSystem { id: particles }

            ImageParticle {
                system: particles
                source: "qrc:/music-note.png"
                alpha: 0.4
                alphaVariation: 0.2
            }

            Emitter {
                system: particles
                emitRate: 1
                lifeSpan: 70000
                velocity: PointDirection { x: -20; xVariation: -50; }
                size: 20
                sizeVariation: 10
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 5
            }

            Image {
                id: name
                width: 150
                height: 150
                anchors.centerIn: parent
                source: "qrc:/no-results.png"
            }
            Text {
                id: aaa
                text: qsTr("No Music found here")
                anchors.left: parent.left
                anchors.leftMargin: (parent.width/2)-aaa.width/2
                anchors.top: parent.top
                anchors.topMargin: parent.height/2 +80
                color: "white"
                font.pixelSize: 18
            }
        }

}









//PathView
//{
//       id: pathView
//       anchors.fill: parent
//       model: songs.count
//       pathItemCount: 5

//       delegate:Rectangle {
//                                    id: item
//                                    height: root.height * 0.5
//                                    width: root.width * 0.25
//                                    radius:30
//                                    border.width: 1
//                                    border.color: "#ffffff"
//                                    color: "transparent"
//                                    scale: PathView.itemscale
//                                    z: PathView.z

//                                    property var rotationAngle: PathView.angle
//                                    property var rotationOrigin: PathView.origin

//                                    Image {
//                                        width: parent.width-10
//                                        height: parent.height-25
//                                        anchors.left: parent.left
//                                        anchors.leftMargin: 5
//                                        scale: 0.8
//                                        source: ((songs.get(index).img)===undefined)?"qrc:/music-note.png":(songs.get(index).img)
//                                    }
//                                    Text {
//                                        id: name
//                                        anchors.top: parent.bottom
//                                        anchors.topMargin: 10
//                                        anchors.left: parent.left
//                                        anchors.leftMargin: (parent.width/2)-(name.width/2)
//                                        color: "#ffffff"
//                                        font.pixelSize: 10
//                                        text: qsTr(songs.get(index).name)
//                                    }
//                                    MouseArea
//                                    {
//                                        anchors.fill:parent
//                                        onClicked:
//                                        {
//                                            currIdx=index
//                                            if((songs.get(index).img)==="qrc:/music-note.png")
//                                            {
//                                                backimg="";
//                                            }
//                                            else
//                                            {
//                                                backimg=(songs.get(index).img)===undefined?"":(songs.get(index).img);
//                                            }

//                                            // here should use the backend to play the mp3
//                                            Mp3Backend.setSong(songs.get(index).name);
//                                            Mp3Backend.play();
//                                        }
//                                    }
//                                }

//       interactive: true
////               pathItemCount: 5
//       preferredHighlightEnd: 0.5
//       preferredHighlightBegin: 0.5

//       onDragStarted: {
//           scrollViewAnimation.stop()
//       }

//       NumberAnimation on offset {
//           id: scrollViewAnimation
//           duration: 2000
//           easing.type: Easing.InOutQuad
//       }

//       path: Path {
//           startX: 0
//           startY: root.height * 0.5

//           PathAttribute { name: "z"; value: 0 }
//           PathAttribute { name: "itemscale"; value: 0.5 }

//           PathLine {
//               x: root.width * 0.5
//               y: root.height * 0.5
//           }

//           PathAttribute { name: "z"; value: 100 }
//           PathAttribute { name: "itemscale"; value: 1 }

//           PathLine {
//               x: root.width
//               y: root.height * 0.5
//           }

//           PathAttribute { name: "z"; value: 0 }
//           PathAttribute { name: "itemscale"; value: 0.5 }




//       }
//}














/// old DelegateModel
//Rectangle {
//                   id: item
//                   height: root.height * 0.5
//                   width: root.width * 0.25
//                   radius:30
//                   border.width: 1
//                   border.color: "#ffffff"
//                   color: "transparent"
//                   scale: PathView.itemscale
//                   z: PathView.z

//                   property var rotationAngle: PathView.angle
//                   property var rotationOrigin: PathView.origin

////                   transform:
////                       Rotation {
////                       id: rot
////                       axis { x: 0; y: 1; z: 0 }
////                       angle: rotationAngle
////                       origin.x: rotationOrigin
////                       origin.y: width
////                   }

////                   transform:
////                   Rectangle
////                   {
////                       id:xyz
////                       anchors.fill: parent
//////                       gradient: backtheme
////                       color: "transparent"
////                       opacity: 1
////                       radius:30
////                       border.width: 1
////                       border.color: "#ffffff"
////                   }
////                   GaussianBlur {
////                       anchors.fill: xyz
////                       source: xyz
////                       radius: 8
////                       samples: 16
////                   }
//                   Image {
//                       width: parent.width-10
//                       height: parent.height-25
//                       anchors.left: parent.left
//                       anchors.leftMargin: 5
//                       scale: 0.8
//                       source: ((songs.get(index).img)===undefined)?"qrc:/music-note.png":(songs.get(index).img)
//                   }
//                   Text {
//                       id: name
//                       anchors.top: parent.bottom
//                       anchors.topMargin: 10
//                       anchors.left: parent.left
//                       anchors.leftMargin: (parent.width/2)-(name.width/2)
//                       color: "#ffffff"
//                       font.pixelSize: 10
//                       text: qsTr(songs.get(index).name)
//                   }
//                   MouseArea
//                   {
//                       anchors.fill:parent
//                       onClicked:
//                       {
//                           currIdx=index
//                           if((songs.get(index).img)==="qrc:/music-note.png")
//                           {
//                               backimg="";
//                           }
//                           else
//                           {
//                               backimg=(songs.get(index).img)===undefined?"":(songs.get(index).img);
//                           }

//                           // here should use the backend to play the mp3
//                           Mp3Backend.setSong(songs.get(index).name);
//                           Mp3Backend.play();
//                       }
//                   }
//               }



















//Rectangle
//{
//    id:root
//    anchors.fill: parent
//    property string slctd: ""

//    Gradient {
//        id: radialGradient
//        GradientStop { position: 0.0; color: "#420847" }
//        GradientStop { position: 1.0; color: "#150d26" }
//        // You can add more GradientStops to define additional colors and positions
//    }

//    // Apply the gradient to the rectangle
//    gradient: radialGradient


//    ListModel
//    {
//        id:mdl
//        ListElement {name:"Patients";       icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"Start";          icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"Credits";        icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"Setting";        icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"Firmware Update";icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"About";          icon:"qrc:/electroEmbeddedLogo.png"}

//        ListElement {name:"Patients2";       icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"Start2";          icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"Credits2";        icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"Setting2";        icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"Firmware Update2";icon:"qrc:/electroEmbeddedLogo.png"}
//        ListElement {name:"About2";          icon:"qrc:/electroEmbeddedLogo.png"}
//    }
//    PathView
//    {
//           id: pathView
//           anchors.fill: root
//           model: mdl.count

//           delegate: Rectangle {
//               id: item
//               height: root.height * 0.5
//               width: root.width * 0.25
//               radius:30
//               border.width: 5
//               border.color: "#8c1496"
//               color: "transparent"

//                Rectangle
//                {
//                    anchors.fill: parent
//                    gradient: radialGradient
//                    radius:30
//                    border.width: 5
//                    border.color: "#8c1496"

//                }

//               scale: PathView.itemscale
//               z: PathView.z
//               Image {
//                   width: parent.width-10
//                   height: parent.height-25
//                   anchors.left: parent.left
//                   anchors.leftMargin: 5
//                   scale: 0.8
//                   source: mdl.get(index).icon
//               }
//               Text {
//                   id: name
//                   anchors.bottom: parent.bottom
//                   anchors.bottomMargin: 5
//                   anchors.left: parent.left
//                   anchors.leftMargin: (parent.width/2)-(name.width/2)
//                   color: "#8c1496"
//                   font.pixelSize: 20
//                   text: qsTr(mdl.get(index).name)
//               }
//               MouseArea
//               {
//                   anchors.fill:parent
//                   onClicked:
//                   {
//                       let selectded=mdl.get(index).name;
//                       console.log(selectded)
//                       if(selectded==="Start")
//                       {
//                           mystack.push(page1)
//                       }
//                       if(selectded==="Patients")
//                       {
//                           mystack.push(patntpge)
//                       }
//                       if(selectded==="Setting")
//                       {
//                           mystack.push(sttngpge)
//                       }
//                       if(selectded==="Firmware Update")
//                       {
//                           mystack.push(swupdpage)
//                       }
//                       if(selectded==="About")
//                       {
//                           mystack.push(abutpge)
//                       }
//                       if(selectded==="Credits")
//                       {
//                           mystack.push(crdtPge)
//                       }
//                   }
//               }
//           }

//           interactive: true

//           pathItemCount: 5
//           preferredHighlightEnd: 0.5
//           preferredHighlightBegin: 0.5

//           path: Path {
//               startX: 0
//               startY: root.height * 0.5

//               PathAttribute { name: "z"; value: 0 }
//               PathAttribute { name: "itemscale"; value: 0.5 }

//               PathLine {
//                   x: root.width * 0.5
//                   y: root.height * 0.5
//               }

//               PathAttribute { name: "z"; value: 100 }
//               PathAttribute { name: "itemscale"; value: 1 }

//               PathLine {
//                   x: root.width
//                   y: root.height * 0.5
//               }

//               PathAttribute { name: "z"; value: 0 }
//               PathAttribute { name: "itemscale"; value: 0.5 }
//           }
//    }
//}
















//    Component {
//        id: highlight
//        Rectangle {
//            width: 180; height: 20
//            color: "grey"; radius: 5
//            opacity: 0.4
//            y: listview.currentItem.y
//            Behavior on y {
//                SpringAnimation {
//                    spring: 3
//                    damping: 0.2
//                }
//            }
//        }
//    }

//    ListView {
//        id:listview
//       anchors.fill: parent
//       anchors.centerIn: parent
//        header: Rectangle{
//            width: listview.width
//            height: listview.height/7
//            anchors.top: parent.top
//            anchors.topMargin: 10
//            color: "transparent"
//            Text {
//                id: header
//                anchors.centerIn: parent
//                color: "white"
//                text: qsTr("PlayList")
//            }
//            Rectangle{
//                id:browse
//                width: 80
//                height: 50
//                anchors.right: parent.right
//                anchors.rightMargin: 10
//                anchors.top: parent.top
//                anchors.topMargin: 10
//                color: "transparent"
//                radius: 8
//                border.width: 1
//                border.color: "#ffffff"
//                Text {
//                    id: name
//                    anchors.centerIn: parent
//                    color: "white"
//                    text: qsTr("Browse")
//                }
//                MouseArea{
//                    anchors.fill: parent
//                    onClicked: {
//                        fileDialog.open();
//                    }
//                    onPressed: {
//                        browse.color="#fafafa"
//                        browse.opacity=0.8
//                    }
//                    onReleased: {
//                          browse.color="transparent"
//                        browse.opacity=1

//                    }
//                }
//            }
//        }
//        model: songs

//        delegate: Item {
//               width: listview.width
//               height: 80
//               Rectangle {
//                   id:itemm
//                   width: parent.width
//                   height: 80
//                   color: "transparent"
//                   anchors.left: parent.left
//                   anchors.leftMargin: 15
//                   radius: 20

//                   Image {
//                       id: imageofSong
//                       width: 50
//                       height: 50
//                       source:(img!=undefined)?img:"qrc:/music-note.png"
//                   }

//                   Column {
//                       width: parent.width - 75
//                       height: parent.height
//                       anchors.left: parent.left
//                       anchors.leftMargin: 60

//                       Text {
//                           id: songName
//                           text: name
//                           font.weight: Font.Bold
//                           color: "white"
//                       }

//                       Text {
//                           id: songArtist
//                           text: (artist!=undefined)?artist:"unknown artist"
//                           font.pixelSize: 15
//                           color: "white"
//                       }
//                   }

//                   MouseArea {
//                       anchors.fill: parent
//                       onClicked: {
//                           if(index>currIdx){
//                             for(let i=currIdx;i<index;i++)
//                             {
//                                 listview.incrementCurrentIndex();
//                             }
//                           }
//                           else{
//                               for(let i=index;i<currIdx;i++)
//                               {
//                                   listview.decrementCurrentIndex();
//                               }
//                           }
//                           currIdx=index
//                           // here should use the backend to play the mp3
//                           Mp3Backend.setSong(name);
//                           Mp3Backend.play();

//                       }
//                       onPressed: {
//                           itemm.color="#f1f1f10505f"
//                       }
//                       onReleased: {
//                           itemm.color="transparent"
//                       }
//                   }
//               }
//           }
//        highlight: highlight
//        highlightMoveDuration: 2000

//    }




