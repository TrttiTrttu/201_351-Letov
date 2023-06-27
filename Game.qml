import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: gamePage
    spacing: 5

    signal buttonClicked(string num)


    TextArea {
        anchors.horizontalCenter: parent
        readOnly: true
        placeholderText: qsTr("Enter description")
    }

    GridLayout {
        id: grid
        anchors.fill: parent

        rows: 3
        columns: 4



        Repeater {
            id: rep
            model: 12
            Button {
                required property int index
                text: "PRESS"
                onClicked: {
                    var button = rep.itemAt(index)
                    if (button.text === "PRESS")
                        button.text = Math.floor(Math.random() * 9999)
                        gamePage.buttonClicked(button.text)
                    }
                }

            }
        }

    Connections {
        target: gamePage
        function onButtonClicked() {
            stackView.push(gamePage);
        }
    }
    }
