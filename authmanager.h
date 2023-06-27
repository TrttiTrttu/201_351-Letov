#ifndef AUTHMANAGER_H
#define AUTHMANAGER_H

#include <QObject>
#include <qDebug>

class authManager : public QObject
{
    Q_OBJECT
public:
    authManager(QString kositl);

    bool checkPin(QString pin);
signals:
    void pinChecked(bool res);
//    void keyCreated(QByteArray key);
//    void alertPopup(QString text);

public slots:
    void onCheckPin(QString pin);

private:
    const QString mPin = "123";

};

#endif // AUTHMANAGER_H
