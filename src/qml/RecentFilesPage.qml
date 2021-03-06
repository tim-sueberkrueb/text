/*
 * Copyright © 2016-2017 Andrew Penkrat
 *
 * This file is part of Liri Text.
 *
 * Liri Text is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Liri Text is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Liri Text.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import Qt.labs.platform 1.0
import Fluid.Controls 1.0 as FluidControls
import Fluid.Core 1.0 as FluidCore
import io.liri.text 1.0

FluidControls.Page {
    id: page

    appBar.title: qsTr("Recent Files")
    actions: [
        FluidControls.Action {
            id: openFile
            iconName: "file/folder_open"
            toolTip: qsTr("Open")
            shortcut: StandardKey.Open
            onTriggered: openFileDialog.open()
        }
    ]

    Component.onCompleted: {
        console.log("start page completed")
    }

    FileDialog {
        id: openFileDialog
        onAccepted: {
            pageStack.push(Qt.resolvedUrl("EditPage.qml"), { documentUrl: openFileDialog.file })
        }
    }

    FileGridView {
        id: recentFilesView
        model: History

        FluidControls.Placeholder {
            visible: recentFilesView.model.count === 0
            anchors.fill: parent
            text: qsTr("You don't have recently open files")
        }
    }

    FluidControls.FloatingActionButton {
        id: newFile

        onClicked: pageStack.push(Qt.resolvedUrl("EditPage.qml"), { anonymous: true })

        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 24

        iconName: "content/create"
        Material.background: Material.accent
    }
}
