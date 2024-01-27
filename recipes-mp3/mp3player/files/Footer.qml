import QtQuick 2.13
 import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12


Rectangle{
    width: parent.width
    height: 80
    color: "transparent"
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    property bool isPlay: Mp3Backend.status
    property int duration :0
    property int val: 0
    property string sname: ""
    Rectangle{
        anchors.fill:parent
        color: "black"
        opacity: 0.35
    }


    Rectangle{
        id:playpause_btn
        color: "transparent"
        anchors.left: prev_btn.right
        width: 40
        height: 40
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 80-50
        radius: 12
        Rectangle{
            anchors.fill: parent
            color: "#ffffff"
            opacity: 0.1
            radius: 12
        }

        Image {
            id: plypause
            width: (isPlay==true)?25:18
            height: (isPlay==true)?25:18
            source:(isPlay==true)?"qrc:/pause.png":"qrc:/play.png"
            anchors.centerIn: parent
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    isPlay=!isPlay
                    if(isPlay==true){
                        myplaylist.play();

                    }
                    else{
                        myplaylist.pause();
                    }
                }
                onPressed: {
                    parent.parent.color="#551133"
                }
                onReleased: {
                    parent.parent.color="transparent"
                }

            }
        }

    }

    Rectangle{
        id:prev_btn
        width: 35
        height: 35
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 10+prev.width
        anchors.top: parent.top
        anchors.topMargin: 80-45
        radius: 6
        Rectangle{
            anchors.fill: parent
            color: "#ffffff"
            opacity: 0.1
            radius: 6
        }
        Image {
            id: prev
            width: 25
            height: 25
            source:"qrc:/previous.png"
            anchors.centerIn: parent
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    // do prev process
                    myplaylist.previous();
                    console.log("previous");
                }
                onPressed: {
                    parent.parent.color="#551133"
                }
                onReleased: {
                   parent.parent.color="transparent"
                }
            }
        }
    }


    Rectangle{
        id:next_btn
        width: 35
        height: 35
        color: "transparent"
        anchors.left: playpause_btn.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin:  80-45
        radius: 6
        Rectangle{
            anchors.fill: parent
            color: "#ffffff"
            opacity: 0.1
            radius: 6
        }
        Image {
            id: next
            width: 25
            height: 25
            source:"qrc:/next-button.png"
            anchors.centerIn: parent
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    // do next process
                    myplaylist.next();
                    console.log("next");
                }
                onPressed: {
                    parent.parent.color="#551133"
                }
                onReleased: {
                    parent.parent.color="transparent"
                }
            }
        }

    }

    Text {
        id: songName
        text:sname
        color: "white"
        font.pixelSize: 15
        anchors.left: next_btn.right
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 25

    }

    ProgressBar {
        id:progress_bar
        width: parent.width-400
        anchors.left: next_btn.right
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 53
        background:  Rectangle {
            opacity: 0.1
            color: "white"
        }
        Material.accent: Material.Pink
        value:  (Mp3Backend.progress===null)?0:Mp3Backend.progress

    }

    Image {
        id: voulume
        width: 25
        height: 25
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.right: vol.left
        anchors.rightMargin:  10
        source: "qrc:/volume.png"

    }
    Slider{
        id :vol
        width: 100
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 30
        Material.accent: Material.Grey
        onValueChanged: {
            console.log(value*100)
            Mp3Backend.setSound(value*100)
        }

    }

}

/*
    Rectangle{
        id:playpause_btn
        color: "transparent"
        anchors.left: parent.left
        width: 35
        height: 35
        anchors.leftMargin: (parent.width/2)-(plypause.width/2)
        anchors.top: parent.top
        anchors.topMargin: 8

        Image {
            id: plypause
            width: 35
            height: 35
            source:(isPlay==true)?"qrc:/pause.png":"qrc:/play.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    isPlay=!isPlay
                    if(isPlay==true){
                        myplaylist.play();

                    }
                    else{
                        myplaylist.pause();
                    }
                }
            }
        }

    }

    Rectangle{
        id:next_btn
        color: "transparent"
        anchors.left: playpause_btn.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 4+11
        Image {
            id: next
            width: 25
            height: 25
            source:"qrc:/next-button.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    // do next process
                    myplaylist.next();
                    console.log("next");
                }
            }
        }

    }



    ProgressBar {
        id:progress_bar
        width: parent.width-250
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2-progress_bar.width/2
        anchors.top: parent.top
        anchors.topMargin: 53
        background:  Rectangle {
            opacity: 0.3
            color: "white"
        }
        Material.accent: Material.Pink
        value:  Mp3Backend.progress

    }

*/
