import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    minimumWidth: 640
    minimumHeight: 480
    maximumWidth: 640
    maximumHeight: 480
    visible: true
    title: "Make transition"
    Rectangle
    {
        id: scene
        anchors.fill: parent
        state: "InitialState"

        Rectangle
        {
            id: leftRectangle
            x: 100
            y: 200
            color: "lightgrey"
            width: 100
            height: width
            border.color: "black"
            border.width: 3
            radius: 5

            MouseArea
            {
                property int myInt: 0
                anchors.fill:parent
                onClicked:
                {
                 myInt = new Date().getTime() % 100 + 0
                 ball.x+= myInt
                 if((ball.x == rightRectangle.x) || (ball.x == (rightRectangle.x + 5)) ||
                         (ball.x == (rightRectangle.width-ball.width + rightRectangle.x)) || (ball.x > (rightRectangle.x + rightRectangle.width)))
                     scene.state = "InitialState"
                 else
                     scene.state = "OtherState"
                }
            }
        }

        Rectangle
        {
            id: rightRectangle
            x: leftRectangle.x * 3
            y: leftRectangle.y
            color: leftRectangle.color
            width: leftRectangle.width
            height: leftRectangle.height
            border.color: leftRectangle.border.color
            border.width: leftRectangle.border.width
            radius: leftRectangle.radius

            MouseArea
            {
                anchors.fill: parent
                onClicked: scene.state = "InitialState"
            }
        }

        Rectangle
        {
            id: ball
            color: "orangered"
            x: leftRectangle.x + 5
            y: leftRectangle.y + 5

            width: leftRectangle.width - 10
            height: width
            radius: height / 2
        }

        Text {
            id: leftRectangleText
            anchors.centerIn: leftRectangle
            color: "brown"
            text:"move"
        }

        Text
        {
            id: rightRectangleText
            anchors.centerIn: rightRectangle
            color: "brown"
            text: "return"
        }

        // 2 состояния
        states:
        [
            State
            {
                name: "InitialState"
                PropertyChanges
                {
                    target: ball
                    x: leftRectangle.x + 5

                }
            },
            State
            {
                name: "OtherState"
                PropertyChanges
                {
                    target: ball
                    x: ball.x
                }
            }
        ]
        transitions:
        [
            Transition {
                from: "OtherState"
                to: "InitialState"

                NumberAnimation
                {
                    properties: "x, y"
                    duration: 1000
                    easing: Easing.OutBack
                }
            }
        ]
    }
}
