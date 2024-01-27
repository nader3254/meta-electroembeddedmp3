import QtQuick 2.13


Rectangle{
    width: parent.width/10*2.5
    height: parent.height
    color: "#000000"
    property string  currentpage: "home"

    Image {
        id: logo
        width: parent.width
        height: parent.height/6
        anchors.top: parent.top
        anchors.topMargin: 25
        source: "qrc:/electroEmbeddedLogo.png"
    }


   // home
   Rectangle{
       id:home
       width: parent.width
       anchors.top:logo.bottom
       anchors.topMargin: 40
       height: 40
       color: (currentpage=="home")?"#551133":"transparent"

       Image{
           id:icon
           width: 25
           height: 25
           anchors.left: parent.left
           anchors.top: parent.top
           anchors.topMargin: 5
           anchors.leftMargin: 30
           source: "qrc:/home.png"
       }

       Text {
           id: name
           anchors.left: icon.right
           anchors.leftMargin: 10
           anchors.top: parent.top
           anchors.topMargin: 10
           text: qsTr("Home")
           color: "#ffffff"
       }
    MouseArea{
        anchors.fill:parent
        onClicked: {

            mystack.pop()
            mystack.push(myplaylist)
        }
        onPressed: {
          currentpage="home"
        }

    }
   }


   // youtube
   Rectangle{
       id:youtube
       width: parent.width
       anchors.top:home.bottom
       anchors.topMargin: 5
       height: 40
       color: (currentpage=="youtube")?"#551133":"transparent"

       Image{
           id:icon2
           width: 25
           height: 25
           anchors.left: parent.left
           anchors.top: parent.top
           anchors.topMargin: 5
           anchors.leftMargin: 30
           source: "qrc:/youtube.png"
       }

       Text {
           id: name2
           anchors.left: icon2.right
           anchors.leftMargin: 10
           anchors.top: parent.top
           anchors.topMargin: 10
           text: qsTr("YouTube")
           color: "#ffffff"
       }
    MouseArea{
        anchors.fill:parent
        onClicked: {
            mystack.pop()
            mystack.push(youtubePage)

        }
        onPressed: {
            currentpage="youtube"
        }

    }
   }

   // soundcloud
   Rectangle{
       id:soundcloud
       width: parent.width
       anchors.top:youtube.bottom
       anchors.topMargin: 5
       height: 40
       color: (currentpage=="soundcloud")?"#551133":"transparent"

       Image{
           id:icon3
           width: 25
           height: 25
           anchors.left: parent.left
           anchors.top: parent.top
           anchors.topMargin: 5
           anchors.leftMargin: 30
           source: "qrc:/soundcloud.png"
       }

       Text {
           id: name3
           anchors.left: icon3.right
           anchors.leftMargin: 10
           anchors.top: parent.top
           anchors.topMargin: 10
           text: qsTr("SoundCloud")
           color: "#ffffff"
       }
    MouseArea{
        anchors.fill:parent
        onClicked: {

            mystack.pop()
            mystack.push(soundcloudPage)

        }
        onPressed: {
            currentpage="soundcloud"
        }
    }
   }

   // setting
   Rectangle{
       id:setting
       width: parent.width
       anchors.top:soundcloud.bottom
       anchors.topMargin:5
       height: 40
       color: (currentpage=="browse")?"#551133":"transparent"

       Image{
           id:icon4
           width: 25
           height: 25
           anchors.left: parent.left
           anchors.top: parent.top
           anchors.topMargin: 5
           anchors.leftMargin: 30
           source: "qrc:/folder.png"
       }

       Text {
           id: name4
           anchors.left: icon4.right
           anchors.leftMargin: 10
           anchors.top: parent.top
           anchors.topMargin: 10
           text: qsTr("Browse")
           color: "#ffffff"
       }
    MouseArea{
        anchors.fill:parent
        onClicked: {

//            mystack.pop()
//            wv.reload()
//            mystack.push(soundcloudPage)
              fileDialog.open();
        }
        onPressed: {
            currentpage="browse"
        }
    }
   }
}
