#include "LeitnerService.h"
#include <QDebug>
#include <QDataStream>

void LeitnerService::run()
{
    lwa = "0";
    m_alarm = settings.value("AlarmInterval").toInt();
    if(!m_alarm){
        installation();
        qDebug() << "installing";
    }
    /*
    if(timer != nullptr){
        delete timer;
    }
    timer = new QTimer();
    timer->start(m_alarm);
    QObject::connect(timer, &QTimer::timeout, this, &LeitnerService::timeout);
    */
}
void LeitnerService::installation()
{
    db.install();
    settings.setValue("AlarmInterval", 100000);
    m_alarm = 100000;
}
bool LeitnerService::timerstat()
{
    return timer->isActive();
}
QVariantMap LeitnerService::getword()
{
    QVariantMap res;
    if(QTime::currentTime().toString("zzz").toInt()%2){
        res = db.fetchWord("1", lwa);
        if(!res["ok"].toBool()){
            res = db.fetchWord("2", lwa);
        }
    }else
    {
        res = db.fetchWord("2", lwa);
        if(!res["ok"].toBool()){
            res = db.fetchWord("1", lwa);
        }
    }
    if(!res["ok"].toBool()){
        res = db.fetchWord("4", lwa);
    }
    if(lwa.size() > 0) lwa += ",";
    lwa += res["id"].toString();
    return res;
}
void LeitnerService::timeout()
{
    QVariantMap  res = getword();
    QString a, b;
    if(res["part"].toInt() == 1){
        a = "translate: "+res["translate"].toString();
        b = "2";
    }else{
        a = "If you didn't remember click this message.";
        b = "3";
    }
    updateAndroidNotification(res["word"].toString(), a);
    timer->start(m_alarm);
    db.moveWord(res["id"].toString(),b);
    emit changes(res["part"].toInt());
}

QVariantList LeitnerService::part(int i)
{
    switch (i) {
        case 1:
        return db.allWords("1");
        break;
    case 2:
        return db.allWords("2");
    break;
    case 3:
        return db.allWords("3");
        break;
    case 4:
        return db.allWords("4");
    break;
    case 5:
        return db.allWords("5");
    break;
    default:
        return {};
    }
}

QVariantList LeitnerService::boxes()
{
    return db.allBoxes();
}
QVariantMap LeitnerService::boxesNames()
{
    return db.installedBoxes();
}

void LeitnerService::move(QString wid, QString target)
{
    db.moveWord(wid,target);
    emit changes(0);
}
bool LeitnerService::download(QString link)
{
    if(cl != nullptr){
        return false;
    }
    cl = new QtDownload();
    cl->setTarget(link);
    QObject::connect(cl, &QtDownload::done, this, &LeitnerService::unpack);
    QObject::connect(cl, &QtDownload::progress, [this](float p){
        emit this->newbox(p, 1);
    });
    cl->download();

    return true;
}
void LeitnerService::unpack(QByteArray data)
{
    cl->deleteLater();
    cl = nullptr;
    if(data.size() < 12){
        emit newbox(0,3);
        return;
    }
    emit newbox(0, 2);
    QString box;
    QStringList words;
    QTextStream in(data);
    box = in.readLine();
    emit newbox(static_cast<float>(0.3), 2);
    while(!in.atEnd())
        words << in.readLine();
    emit newbox(1, 2);
    db.installBox(box, words);
    emit newbox(1, 3);
}
void LeitnerService::activate(QString boxid)
{
    db.activate(boxid);
    emit changes(0);
}
void LeitnerService::deactivate(QString boxid)
{
    db.deactivate(boxid);
    emit changes(0);
}

void LeitnerService::removeBox(QString bid)
{
    db.removeBox(bid);
    emit changes(0);
}

QVariantMap LeitnerService::getLast()
{
    return db.fetchById(lwa);
}
QVariant LeitnerService::setting(QString name)
{
    return settings.value(name);
}
void LeitnerService::sett(QString name, QVariant val)
{
    settings.setValue(name, val);
}
void LeitnerService::setAlarm(int val)
{
    settings.setValue("AlarmInterval", val);
    m_alarm = val;
}
void LeitnerService::updateAndroidNotification(QString title, QString notif)
{
    id++;
    QAndroidJniObject javaTitle = QAndroidJniObject::fromString(title);
    QAndroidJniObject javaNotification = QAndroidJniObject::fromString(notif);
    QAndroidJniObject::callStaticMethod<void>(
        "ir/JDGhayenat/Leitner/LeitnerService",
        "notify",
        "(Landroid/content/Context;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;)V",
        QtAndroid::androidContext().object(),
        id,
        javaTitle.object<jstring>(),
        javaNotification.object<jstring>()
    );
}
