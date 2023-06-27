import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Window {
    id: window
    width: 640
    height: 480
    minimumHeight: 400
    minimumWidth: 250
    visible: true
    title: qsTr("Random game")

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: loginPage
    }

    Login {
        id: loginPage
    }

    Game {
        id: gamePage
        visible: false
    }

    Connections {
        target: loginPage
        function onSuccessPin() {
            stackView.push(gamePage);
        }
    }
}
