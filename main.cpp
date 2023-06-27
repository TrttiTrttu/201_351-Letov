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

    return app.exec();
}
