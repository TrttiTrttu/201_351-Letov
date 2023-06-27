#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "windows.h"
#include <authmanager.h>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();

    authManager auth("qwer");
    context->setContextProperty("auth", &auth);




    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);


    QObject *authPage = engine.rootObjects().constFirst()->children().at(2);
    QObject::connect(authPage, SIGNAL(checkPin(QString)), &auth, SLOT(onCheckPin(QString)));

//    QObject *dataPage = engine.rootObjects().constFirst()->children().at(3);
//    QObject::connect(dataPage, SIGNAL(entryDeleteClicked()), &listcontroller, SLOT(onEntryDeleteClicked()));
//    QObject::connect(dataPage, SIGNAL(copyToBuffer(int, QString)), &listcontroller, SLOT(onCopyToBuffer(int, QString)));

//    QObject *formPage = engine.rootObjects().constFirst()->children().at(4);
//    QObject::connect(formPage, SIGNAL(checkCreateEntry(QString, QString, QString)), &listcontroller, SLOT(onCheckCreateEntry(QString, QString, QString)));

    return app.exec();
}
