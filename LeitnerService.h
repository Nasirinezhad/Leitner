#ifndef LEITNERSERVICE_H
#define LEITNERSERVICE_H
#include <QSettings>
#include <QTimer>
#include "db.h"
#include "qtdownload.h"
#include <QtAndroid>
#include <QAndroidService>
#include <QAndroidIntent>
#include <QObject>

class LeitnerService : public QObject
{
    Q_OBJECT
public slots:
    void run();
    QVariantList part(int i);
    QVariantList boxes();
    QVariantMap boxesNames();
    void move(QString wid, QString target);
    bool download(QString link);
    void activate(QString boxid);
    void deactivate(QString boxid);
    void removeBox(QString bid);
    QVariantMap getLast();
    void updateAndroidNotification(QString title, QString notif);
    QVariant setting(QString name);
    void sett(QString name, QVariant val);
    void setAlarm(int val);
    bool timerstat();
    QVariantMap getword();
private slots:
    void unpack(QByteArray data);

signals:
    void alarm(QString title, QString message);
    void changes(int p);
    void newbox(float percent, int stat = 1);
private:
    void installation();
    QSettings settings;
    DB db;
    QtDownload *cl = nullptr;
    int m_alarm = 0; //Alarm interval time
    int id = 0;
    QTimer *timer = nullptr;
    QString lwa; // Last Word Alarmed
private slots:
    void timeout();

};

#endif // LEITNERSERVICE_H
