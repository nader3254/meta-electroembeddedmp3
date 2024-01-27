
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTimer>
#include <QQmlContext>
#include <math.h>
#include <QDebug>
#include "mp3backend.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    // Set the organization name and domain
    QCoreApplication::setOrganizationName("com.electroembedded");
    QCoreApplication::setOrganizationDomain("https://www.youtube.com/@ElectroEmbedded-02/playlists");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    // adding my custom qml types
    Mp3Backend mybackend;
    engine.rootContext()->setContextProperty("Mp3Backend", &mybackend);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


//   player->setMedia(QUrl::fromLocalFile("/home/nader/Desktop/hellomp3.workingDir/rosy-125bpm-fminor-song-163434.mp3.mp3"));
//   player->setVolume(100);
//   player->play();


    return app.exec();
}

