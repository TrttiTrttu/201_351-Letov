import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: gamePage
    spacing: 5

    signal buttonClicked(string num)
    signal gameEnd
    signal refreshField

    TextArea {
        id: score
        anchors.horizontalCenter: parent
        readOnly: true
        placeholderText: qsTr("0")
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
                    if (button.text === "PRESS") {
                        button.text = Math.floor(Math.random() * 9999)
                        gamePage.buttonClicked(button.text)
                    }
                }
            }
        }
    }

    Connections {
        target: gamePage
        function onButtonClicked(num) {
            score.placeholderText = parseInt(
                        score.placeholderText) + parseInt(num)
            var count = 0
            for (var i = 0; i < rep.count; i++) {
                if (rep.itemAt(i).text !== "PRESS") {
                    count = count + 1
                }

                if (count === 4) {
                    gamePage.refreshField()
                }
            }
        }
    }

    Connections {
        target: gamePage
        function onRefreshField() {
            score.placeholderText = 0
            for (var i = 0; i < rep.count; i++) {
                rep.itemAt(i).text = "PRESS"
            }
        }
    }
}
