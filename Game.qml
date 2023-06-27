import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: gamePage
    spacing: 5

    signal buttonClicked(string num)
    signal refreshField

    Popup {
        id: popup
        anchors.centerIn: Overlay.overlay
        width: 300
        height: 250
        modal: true
        focus: true

        ColumnLayout {
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Label {
                id: label
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 18
                text: ""
            }
        }
    }

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
            var result = parseInt(score.placeholderText) + parseInt(num)
            score.placeholderText = result
            var count = 0

            for (var i = 0; i < rep.count; i++) {
                if (rep.itemAt(i).text !== "PRESS") {
                    count = count + 1
                }

                if (count === 4) {
                    label.text = "Result: " + result
                    gamePage.refreshField()
                    popup.open()
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
