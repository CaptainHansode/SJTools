# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'D:\Project_TA\GrpTools\dcc\common\max\maxscript\scripts\Python\GrpPython\selecton\test_ui.ui'
#
# Created: Fri Jul  6 19:22:17 2018
#      by: pyside2-uic  running on PySide2 2.0.0~alpha0
#
# WARNING! All changes made in this file will be lost!

from PySide2 import QtCore, QtGui, QtWidgets

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(377, 283)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.verticalLayout_3 = QtWidgets.QVBoxLayout(self.centralwidget)
        self.verticalLayout_3.setObjectName("verticalLayout_3")
        self.mainArea = QtWidgets.QScrollArea(self.centralwidget)
        self.mainArea.setWidgetResizable(True)
        self.mainArea.setObjectName("mainArea")
        self.mainAreaWidgetContents = QtWidgets.QWidget()
        self.mainAreaWidgetContents.setGeometry(QtCore.QRect(0, 0, 468, 468))
        self.mainAreaWidgetContents.setObjectName("mainAreaWidgetContents")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.mainAreaWidgetContents)
        self.verticalLayout.setObjectName("verticalLayout")
        self.frame = QtWidgets.QFrame(self.mainAreaWidgetContents)
        self.frame.setMinimumSize(QtCore.QSize(450, 150))
        self.frame.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame.setObjectName("frame")
        self.bg_img = QtWidgets.QLabel(self.frame)
        self.bg_img.setGeometry(QtCore.QRect(10, 10, 381, 291))
        self.bg_img.setAlignment(QtCore.Qt.AlignLeading|QtCore.Qt.AlignLeft|QtCore.Qt.AlignTop)
        self.bg_img.setObjectName("bg_img")
        self.testBt = QtWidgets.QPushButton(self.frame)
        self.testBt.setGeometry(QtCore.QRect(20, 30, 75, 23))
        self.testBt.setObjectName("testBt")
        self.verticalLayout.addWidget(self.frame)
        self.mainArea.setWidget(self.mainAreaWidgetContents)
        self.verticalLayout_3.addWidget(self.mainArea)
        self.scrollArea = QtWidgets.QScrollArea(self.centralwidget)
        self.scrollArea.setMinimumSize(QtCore.QSize(0, 96))
        self.scrollArea.setWidgetResizable(True)
        self.scrollArea.setObjectName("scrollArea")
        self.subAreaWidgetContents = QtWidgets.QWidget()
        self.subAreaWidgetContents.setGeometry(QtCore.QRect(0, 0, 357, 94))
        self.subAreaWidgetContents.setObjectName("subAreaWidgetContents")
        self.verticalLayout_2 = QtWidgets.QVBoxLayout(self.subAreaWidgetContents)
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.selModeGb = QtWidgets.QGroupBox(self.subAreaWidgetContents)
        self.selModeGb.setObjectName("selModeGb")
        self.verticalLayout_5 = QtWidgets.QVBoxLayout(self.selModeGb)
        self.verticalLayout_5.setSpacing(6)
        self.verticalLayout_5.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_5.setObjectName("verticalLayout_5")
        self.hint = QtWidgets.QLabel(self.selModeGb)
        self.hint.setMaximumSize(QtCore.QSize(16777215, 12))
        self.hint.setObjectName("hint")
        self.verticalLayout_5.addWidget(self.hint)
        self.horizontalRbLayout = QtWidgets.QHBoxLayout()
        self.horizontalRbLayout.setContentsMargins(-1, -1, -1, 0)
        self.horizontalRbLayout.setObjectName("horizontalRbLayout")
        self.nameSelRb = QtWidgets.QRadioButton(self.selModeGb)
        self.nameSelRb.setChecked(True)
        self.nameSelRb.setObjectName("nameSelRb")
        self.horizontalRbLayout.addWidget(self.nameSelRb)
        self.searchSelRb = QtWidgets.QRadioButton(self.selModeGb)
        self.searchSelRb.setObjectName("searchSelRb")
        self.horizontalRbLayout.addWidget(self.searchSelRb)
        self.searchTreeSelRb = QtWidgets.QRadioButton(self.selModeGb)
        self.searchTreeSelRb.setObjectName("searchTreeSelRb")
        self.horizontalRbLayout.addWidget(self.searchTreeSelRb)
        self.verticalLayout_5.addLayout(self.horizontalRbLayout)
        self.runCb = QtWidgets.QCheckBox(self.selModeGb)
        self.runCb.setStyleSheet("background:rgb(255, 64, 0);\n"
"font:rgb(32, 32, 32)")
        self.runCb.setChecked(True)
        self.runCb.setObjectName("runCb")
        self.verticalLayout_5.addWidget(self.runCb)
        self.verticalLayout_2.addWidget(self.selModeGb)
        self.scrollArea.setWidget(self.subAreaWidgetContents)
        self.verticalLayout_3.addWidget(self.scrollArea)
        self.verticalLayout_3.setStretch(0, 1)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 377, 24))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QtWidgets.QApplication.translate("MainWindow", "MainWindow", None, -1))
        self.bg_img.setText(QtWidgets.QApplication.translate("MainWindow", "TextLabel", None, -1))
        self.testBt.setText(QtWidgets.QApplication.translate("MainWindow", "PushButton", None, -1))
        self.selModeGb.setTitle(QtWidgets.QApplication.translate("MainWindow", "Option", None, -1))
        self.hint.setText(QtWidgets.QApplication.translate("MainWindow", "hint", None, -1))
        self.nameSelRb.setText(QtWidgets.QApplication.translate("MainWindow", "名前で選択", None, -1))
        self.searchSelRb.setText(QtWidgets.QApplication.translate("MainWindow", "シーンから検索", None, -1))
        self.searchTreeSelRb.setText(QtWidgets.QApplication.translate("MainWindow", "ツリーから検索", None, -1))
        self.runCb.setText(QtWidgets.QApplication.translate("MainWindow", "ボタンの内容も実行", None, -1))

