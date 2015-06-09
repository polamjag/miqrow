import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import MiqRow 0.1

ApplicationWindow {
  visible: true
  width: 300
  height: 500
  title: "miqrow"

  menuBar: MenuBar {
    Menu { MenuItem {} }
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10

    RowLayout {
      Layout.fillWidth: true
      Layout.preferredHeight: 20
      TextField {
        id: postField
        placeholderText: "What's going on?"
        Layout.fillWidth: true
      }
      Button {
        id: postButton
        text: "Post"
        onClicked: controller.update()
      }
    }

    TabView {
      Layout.fillWidth: true
      Layout.fillHeight: true

      Tab {
        title: "Home"

        ScrollView {
          Layout.fillHeight: true
          Layout.fillWidth: true
          Timeline {
            model: controller.posts
          }
        }
      }
    }
  }

  AppController {
    id: controller
    post: postField.text
  }
}
