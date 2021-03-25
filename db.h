#ifndef DB_H
#define DB_H
#include <QObject>
#include <QSqlDatabase>
#include <QVariantMap>
#include <QVariantList>


class DB : public QObject
{
    Q_OBJECT
public:
    DB();
    virtual ~DB() {}

public slots:
    void install();
    void installBox(QString box, QStringList words);
    void removeBox(QString bid);
    QVariantMap fetchWord(QString part, QString lid);
    QVariantMap fetchById(QString id);
    QVariantList allWords(QString part);
    QVariantList allBoxes();
    QVariantMap installedBoxes();
    bool moveWord(QString wordId, QString target);
    bool activate(QString boxId);
    bool deactivate(QString boxId);

private:
    QSqlDatabase db;
};


#endif // DB_H
