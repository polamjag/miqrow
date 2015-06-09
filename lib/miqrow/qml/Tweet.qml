import QtQuick 2.2
import QtQuick.Layouts 1.1

Component {
  RowLayout {
    Image {
      id: icon
      width: 100
      height: 100
      source: user_icon
    }

    ColumnLayout {
      width: 300
      Text {
        font.bold: true
        text: user_name
      }
      Text {
        width: 400
        text: tweet_text
        wrapMode: Text.WrapAnywhere
      }
    }
  }
}