QT += quick

HEADERS += \
    authmanager.h

SOURCES += \
    authmanager.cpp \
    main.cpp

resources.files = main.qml
resources.prefix = /$${TARGET}

QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += resources \
    qml.qrc \

OTHER_FILES += \
    main.qml \
    Login.qml \


