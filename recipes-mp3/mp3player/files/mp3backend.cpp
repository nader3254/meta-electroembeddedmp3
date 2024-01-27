#include "mp3backend.h"
#include <QDebug>
#include <QDir>
#include <QStringList>

Mp3Backend::Mp3Backend(QObject *parent)
    : QObject{parent}
{
    // Initialize your player and other variables here
    player = new QMediaPlayer(this);

    // Connect signals to update QML properties
    connect(player, &QMediaPlayer::positionChanged, this, &Mp3Backend::progressChanged);
    connect(player, &QMediaPlayer::stateChanged, this, &Mp3Backend::statusChanged);
}

void Mp3Backend::saveAlbumArt(const TagLib::ID3v2::AttachedPictureFrame *frame, const char *outputFileName)
{
    if (!frame) {
        qDebug()<<"error no album artist found ...";
        return;
    }

    TagLib::ByteVector imageData = frame->picture();

    FILE *imageFile = fopen(outputFileName, "wb");
    if (imageFile) {
        fwrite(imageData.data(), 1, imageData.size(), imageFile);
        fclose(imageFile);
        qDebug()<<"Album art saved as "<<outputFileName;
    } else {
        qDebug()<<"Error saving album art.";
    }
}

void Mp3Backend::getMetadata(const char *filePath)
{
    TagLib::MPEG::File mpegFile(filePath);

    if (!mpegFile.isValid() || !mpegFile.hasID3v2Tag()) {
        qDebug()<<"Error loading "<<filePath;
        return;
    }

    TagLib::ID3v2::Tag *id3v2Tag = mpegFile.ID3v2Tag();

    // Get metadata
    QString artist=id3v2Tag->artist().toCString(true);
//    std::cout << "Title: " << id3v2Tag->title().toCString(true) << std::endl;
//    std::cout << "Artist: " << id3v2Tag->artist().toCString(true) << std::endl;
//    std::cout << "Album: " << id3v2Tag->album().toCString(true) << std::endl;
//    std::cout << "Year: " << id3v2Tag->year() << std::endl;
//    std::cout << "Genre: " << id3v2Tag->genre().toCString(true) << std::endl;

    // Get album art
    const TagLib::ID3v2::FrameList &frameList = id3v2Tag->frameList("APIC");
    if (!frameList.isEmpty()) {
        const TagLib::ID3v2::AttachedPictureFrame *picFrame = dynamic_cast<const TagLib::ID3v2::AttachedPictureFrame *>(frameList.front());
        QString s = QString(filePath) + ".jpg";
        saveAlbumArt(picFrame, s.toUtf8());
        metaData tmp;
        tmp.filename = QString(filePath);
        tmp.artist = QString(artist);
        tmp.cover ="file://"+ QString(filePath) + ".jpg";
        m_metadata<<tmp;

    } else {
        qDebug()<<"No album art found.";
        metaData tmp;
        tmp.filename=filePath;
        tmp.artist=artist;
        tmp.cover="qrc:/music-note.png";
        m_metadata<<tmp;
    }
}

QStringList Mp3Backend::getFiles()
{
    QString directoryPath=m_workingDir;
    QStringList fileList;

    // Create a QDir object for the specified directory path
    QDir directory(directoryPath);

    // Check if the directory exists
    if (!directory.exists())
    {
        qDebug() << "Directory does not exist:" << directoryPath;
        return fileList;
    }

    // Set the QDir filter to include only files (not directories)
    directory.setFilter(QDir::Files | QDir::NoDotAndDotDot);

    // Get the list of files in the directory
    QStringList files = directory.entryList();

    // Append the file names to the result list
    foreach (const QString& file, files)
    {
        if(!file.contains(".jpg"))
            fileList.append(file);
    }
    m_workingDirfiles=fileList;

    return fileList;
}

QStringList Mp3Backend::getArtists()
{
    for(auto i : m_workingDirfiles){
        player->setMedia(QUrl::fromLocalFile(m_workingDir+"/"+i));
        qDebug()<<    m_workingDir+"/"+i;
        qDebug()<<"############################";
        QString s=m_workingDir+"/"+i;
        getMetadata(s.toUtf8());
    }
    for (auto i : m_metadata) {
        m_songArtists<< i.artist;
    }
    return m_songArtists;
}

QList<QUrl> Mp3Backend::getCovers()
{
    for(auto i : m_metadata)
    {
        m_songCoversBase64 << QUrl(i.cover);
    }

    return m_songCoversBase64;
}

QString Mp3Backend::exportQMLPath(QString file)
{
    return "file://"+m_workingDir+"/"+file;
}

void Mp3Backend::setWorkingDir(QString path)
{
    m_workingDir=path.replace("file://","");
    m_workingDir.replace("file://","");
    qDebug()<<"hello"<<m_workingDir;
}

void Mp3Backend::setSound(int level)
{
    player->setVolume(level);
}

void Mp3Backend::play()
{
    player->play();
    m_state=true;
    emit statusChanged();
}

void Mp3Backend::setSong(QString song)
{
    player->setMedia(QUrl::fromLocalFile(m_workingDir+"/"+song));
}

void Mp3Backend::pause()
{
    player->pause();
    m_state=false;
    emit statusChanged();
}


float Mp3Backend::getProgress() const
{
    if (player)
        return static_cast<float>(player->position()) / player->duration();
    return 0.0;
}

bool Mp3Backend::getState() const
{
    if(m_state==true)
    {
        return true;
    }
    return false;
}
