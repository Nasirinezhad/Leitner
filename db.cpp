#include "db.h"
#include <QDebug>
#include <QSqlQuery>
#include <QSqlError>
DB::DB()
{

    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("Leitner");
    if (!db.open()) {
        qDebug() << "Err";
    }
}
void DB::install()
{
    QSqlQuery query;
    query.exec("create table words (id INTEGER  PRIMARY KEY AUTOINCREMENT, boxid int, word varchar(128), translate varchar(128), descripton varchar(1024), part int)");
    query.exec("create table boxes (id INTEGER  PRIMARY KEY AUTOINCREMENT, words int, name varchar(128), descripton varchar(1024), stat tinyint(1))");

}
void DB::installBox(QString box, QStringList words)
{
    QSqlQuery query;
    query.exec("INSERT into boxes(words, name, descripton, stat) values("+box+",0)");
    query.exec("SELECT MAX(id) FROM boxes");
    if(query.first()){
        QString boxId = query.value(0).toString();
        for (int i = words.size()-1; i >= 0; i--){
            query.exec("INSERT into words(boxid, word, translate, descripton, part) values("+boxId+","+words.at(i)+",6)");
        }
    }
}
void DB::removeBox(QString bid)
{
    QSqlQuery query;
    query.exec("DELETE FROM boxes WHERE id="+bid);
    query.exec("DELETE FROM words WHERE boxid="+bid);
}

QVariantMap DB::fetchWord(QString part, QString lid)
{
    QSqlQuery query;
    QVariantMap  res;
    query.exec("SELECT * FROM words where part="+part+" AND id NOT IN ["+lid+"]");
    if(query.lastError().type() == 2){
        install();
    }
    if(query.first()){
        res["ok"] = true;
        res["id"] = query.value(0).toInt();
        res["boxid"] = query.value(1).toInt();
        res["word"] = query.value(2).toString();
        res["translate"] = query.value(3).toString();
        res["descripton"] = query.value(4).toString();
        res["part"] = query.value(5).toInt();
        return  res;
    }
    res["ok"] = false;
    return res;
}

QVariantMap DB::fetchById(QString id)
{
    QSqlQuery query;
    QVariantMap  res;
    query.exec("SELECT * FROM words where id="+id);
    if(query.first()){
        res["ok"] = true;
        res["id"] = query.value(0).toInt();
        res["boxid"] = query.value(1).toInt();
        res["word"] = query.value(2).toString();
        res["translate"] = query.value(3).toString();
        res["descripton"] = query.value(4).toString();
        res["part"] = query.value(5).toInt();

        return  res;
    }
    res["ok"] = false;
    return res;
}

QVariantList DB::allWords(QString part)
{
    QSqlQuery query;
    QVariantMap  r;
    QVariantList res;
    query.exec("SELECT * FROM words where part="+part);
    while(query.next()){
        r["id"] = query.value(0).toInt();
        r["boxid"] = query.value(1).toInt();
        r["word"] = query.value(2).toString();
        r["translate"] = query.value(3).toString();
        r["descripton"] = query.value(4).toString();
        r["part"] = query.value(5).toInt();
        res.append(r);
    }
    return res;
}

QVariantList DB::allBoxes()
{
    QSqlQuery query;
    QVariantMap  r;
    QVariantList res;
    query.exec("SELECT * FROM boxes");
    while(query.next()){
        r["id"] = query.value(0).toInt();
        r["words"] = query.value(1).toInt();
        r["name"] = query.value(2).toString();
        r["descripton"] = query.value(3).toString();
        r["stat"] = query.value(4).toInt();
        res.append(r);
    }
    return res;
}
QVariantMap DB::installedBoxes()
{
    QSqlQuery query;
    QVariantMap res;
    query.exec("SELECT * FROM boxes");
    while(query.next()){
        res[query.value(2).toString()] = query.value(0).toInt();
    }
    return res;
}

bool DB::moveWord(QString wordId, QString target)
{
    QSqlQuery query;
    query.exec("UPDATE words set part="+target+" Where id="+wordId);
    return query.isValid();
}
bool DB::activate(QString boxId)
{
    QSqlQuery query;
    query.exec("UPDATE words set part=part-5 Where boxid="+boxId);
    query.exec("UPDATE boxes set stat=1 Where id="+boxId);
    return query.isValid();
}
bool DB::deactivate(QString boxId)
{
    QSqlQuery query;
    query.exec("UPDATE words set part=part+5 Where boxid="+boxId);
    query.exec("UPDATE boxes set stat=0 Where id="+boxId);
    return query.isValid();
}
