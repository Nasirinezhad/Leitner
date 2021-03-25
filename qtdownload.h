#ifndef QTDOWNLOAD_H
#define QTDOWNLOAD_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class QtDownload : public QObject
{
    Q_OBJECT
public:
    QtDownload();
    virtual ~QtDownload() {}

public slots:
    void setTarget(const QString &t);
    void downloadFinished(QNetworkReply *data);
    void download();
    void downloadProgress(qint64 recieved, qint64 total);

signals:
    void done(QByteArray);
    void progress(float);
private:
    QNetworkAccessManager manager;
    QString target;
};


#endif // QTDOWNLOAD_H
