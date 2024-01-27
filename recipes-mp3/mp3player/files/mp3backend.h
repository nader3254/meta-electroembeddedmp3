#ifndef MP3BACKEND_H
#define MP3BACKEND_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaMetaData>
#include <QTextStream>
#include <QImage>
#include <QPixmap>
#include <QDebug>
#include <QBuffer>
#include <taglib/taglib.h>
#include <taglib/mpegfile.h>
#include <taglib/id3v2tag.h>
#include <taglib/attachedpictureframe.h>


struct metaData
{
    QString filename;
    QString artist;
    QString cover;
};

class Mp3Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float progress READ getProgress NOTIFY progressChanged)
    Q_PROPERTY(bool status READ getState NOTIFY statusChanged)

public:
    explicit Mp3Backend(QObject *parent = nullptr);

private:
    QString m_workingDir="";
    QStringList m_workingDirfiles;
    QMediaPlayer* player;
    QList<QImage> m_songCovers;
    QStringList m_songArtists;
    QList<QUrl> m_songCoversBase64;
    bool m_state=false;
    QList<metaData> m_metadata;

    void saveAlbumArt(const TagLib::ID3v2::AttachedPictureFrame *frame, const char *outputFileName);
    void getMetadata(const char *filePath);

signals:
    void progressChanged();
    void statusChanged();

public slots:
    QStringList getFiles();
    QStringList getArtists();
    QList<QUrl> getCovers();
    QString exportQMLPath(QString file);
    void setWorkingDir(QString path);
    void setSound(int level);
    void play();
    void setSong(QString song);
    void pause();
    bool getState() const;
    float getProgress() const;



};

#endif // MP3BACKEND_H
