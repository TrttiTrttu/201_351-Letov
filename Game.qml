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
        padding: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        width: parent.width / 2
        readOnly: true
        text: qsTr("0")
    }

    GridLayout {
        id: grid
        anchors.fill: parent
        anchors.top: score
        anchors.topMargin: 75
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        rows: 4
        columns: 3

        Repeater {
            id: rep
            anchors.fill: parent
            model: 12
            Button {
                required property int index
                font.pixelSize: 20
                text: "PRESS"
                Layout.preferredWidth: grid.width / 3
                Layout.preferredHeight: grid.height / 4
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
            var result = parseInt(score.text) + parseInt(num)
            score.text = result
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
            score.text = 0
            for (var i = 0; i < rep.count; i++) {
                rep.itemAt(i).text = "PRESS"
            }
        }
    }
}
