R=5.0

import WebGui
from StartPage import StartPage

class WebPage(object):
    def __init__(self):
        self.browser=WebGui.openBrowserWindow('Start page')
        self.browser.setHtml(StartPage.handle(), 'file://' + App.getResourceDir() + 'Mod/Start/StartPage/')
    def onChange(self, par, reason):
        if reason == 'RecentFiles':
            self.browser.setHtml(StartPage.handle(), 'file://' + App.getResourceDir() + 'Mod/Start/StartPage/')

class WebView(object):
    def __init__(self):
        self.pargrp = FreeCAD.ParamGet('User parameter:BaseApp/Preferences/RecentFiles')
        self.webPage = WebPage()
        self.pargrp.Attach(self.webPage)
    def __del__(self):
        self.pargrp.Detach(self.webPage)

webView=WebView()

import FreeCAD
FreeCAD.open(u"/home/fredrik/kursFOSS/presDag1/CAD/conrod.fcstd")
App.setActiveDocument("conrod")
App.ActiveDocument=App.getDocument("conrod")
Gui.ActiveDocument=Gui.getDocument("conrod")
Gui.ActiveDocument.setEdit('Fillet',0)
__fillets__ = []
__fillets__.append((1,R,R))
__fillets__.append((2,R,R))
FreeCAD.ActiveDocument.Fillet.Edges = __fillets__
del __fillets__
FreeCADGui.ActiveDocument.Pad.Visibility = False

Gui.ActiveDocument.Fillet.LineColor=Gui.ActiveDocument.Pad.LineColor
Gui.ActiveDocument.Fillet.PointColor=Gui.ActiveDocument.Pad.PointColor
Gui.activeDocument().resetEdit()
