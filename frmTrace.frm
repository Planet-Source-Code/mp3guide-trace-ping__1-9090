VERSION 5.00
Begin VB.Form frmTrace 
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Trace & Ping"
   ClientHeight    =   2985
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5445
   Icon            =   "frmTrace.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2985
   ScaleWidth      =   5445
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton Command4 
      Caption         =   "Exit"
      Height          =   225
      Left            =   4050
      TabIndex        =   16
      Top             =   855
      Width           =   1200
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Ping"
      Height          =   225
      Left            =   4665
      TabIndex        =   8
      Top             =   630
      Width           =   600
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      Height          =   315
      Left            =   90
      TabIndex        =   7
      Text            =   "www.yahoo.com"
      Top             =   240
      Width           =   1965
   End
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
      Height          =   315
      Left            =   3480
      MaxLength       =   3
      TabIndex        =   6
      Text            =   "255"
      Top             =   795
      Width           =   390
   End
   Begin VB.TextBox Text3 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   9
         Charset         =   255
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   30
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      Top             =   1605
      Width           =   5355
   End
   Begin VB.TextBox Text4 
      Alignment       =   2  'Center
      Height          =   315
      Left            =   3480
      MaxLength       =   1
      TabIndex        =   4
      Text            =   "5"
      Top             =   -15
      Width           =   390
   End
   Begin VB.TextBox Text5 
      Height          =   315
      Left            =   3480
      TabIndex        =   3
      Text            =   "32"
      Top             =   390
      Width           =   390
   End
   Begin VB.CommandButton Command3 
      Caption         =   "&Trace"
      Height          =   225
      Left            =   4065
      TabIndex        =   2
      Top             =   630
      Width           =   615
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Clear View"
      Height          =   225
      Left            =   4050
      TabIndex        =   1
      Top             =   390
      Width           =   1215
   End
   Begin VB.TextBox Text6 
      Height          =   315
      Left            =   1875
      TabIndex        =   0
      Text            =   "10"
      Top             =   1215
      Width           =   390
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "Host Name :"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   0
      TabIndex        =   15
      Top             =   15
      Width           =   975
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "IPAddress :"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   105
      TabIndex        =   14
      Top             =   615
      Width           =   870
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Height          =   315
      Left            =   105
      TabIndex        =   13
      Top             =   840
      Width           =   1965
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "TTL :"
      ForeColor       =   &H00FF0000&
      Height          =   240
      Left            =   2955
      TabIndex        =   12
      Top             =   840
      Width           =   390
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "# of Packets :"
      ForeColor       =   &H00FF0000&
      Height          =   240
      Left            =   2175
      TabIndex        =   11
      Top             =   0
      Width           =   1140
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "# of Chars/Pkt :"
      ForeColor       =   &H00FF0000&
      Height          =   240
      Left            =   2205
      TabIndex        =   10
      Top             =   405
      Width           =   1140
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "Request T/O (seconds):"
      ForeColor       =   &H00FF0000&
      Height          =   240
      Left            =   90
      TabIndex        =   9
      Top             =   1245
      Width           =   1740
   End
End
Attribute VB_Name = "frmTrace"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' WSock32 Variables

Dim iReturn As Long, sLowByte As String, sHighByte As String
Dim sMsg As String, HostLen As Long, Host As String
Dim Hostent As Hostent, PointerToPointer As Long, ListAddress As Long
Dim WSAdata As WSAdata, DotA As Long, DotAddr As String, ListAddr As Long
Dim MaxUDP As Long, MaxSockets As Long, i As Integer
Dim description As String, status As String

' ICMP Variables

Dim bReturn As Boolean, hIP As Long
Dim szBuffer As String
Dim Addr As Long
Dim RCode As String
Dim RespondingHost As String

' TRACERT Variables

Dim TraceRT As Boolean
Dim TTL As Integer


' WSock32 Constants

Const WS_VERSION_MAJOR = &H101 \ &H100 And &HFF&
Const WS_VERSION_MINOR = &H101 And &HFF&
Const MIN_SOCKETS_REQD = 0
Sub vbIcmpCloseHandle()
  
    bReturn = IcmpCloseHandle(hIP)
    
    If bReturn = False Then
        MsgBox "ICMP Closed with Error", vbOKOnly, "VB4032-ICMPEcho"
    End If

End Sub

Sub GetRCode()

    If pIPe.status = 0 Then RCode = "Success"
    If pIPe.status = 11001 Then RCode = "Buffer too Small"
    If pIPe.status = 11002 Then RCode = "Dest Network Not Reachable"
    If pIPe.status = 11003 Then RCode = "Dest Host Not Reachable"
    If pIPe.status = 11004 Then RCode = "Dest Protocol Not Reachable"
    If pIPe.status = 11005 Then RCode = "Dest Port Not Reachable"
    If pIPe.status = 11006 Then RCode = "No Resources Available"
    If pIPe.status = 11007 Then RCode = "Bad Option"
    If pIPe.status = 11008 Then RCode = "Hardware Error"
    If pIPe.status = 11009 Then RCode = "Packet too Big"
    If pIPe.status = 11010 Then RCode = "Rqst Timed Out"
    If pIPe.status = 11011 Then RCode = "Bad Request"
    If pIPe.status = 11012 Then RCode = "Bad Route"
    If pIPe.status = 11013 Then RCode = "TTL Exprd in Transit"
    If pIPe.status = 11014 Then RCode = "TTL Exprd Reassemb"
    If pIPe.status = 11015 Then RCode = "Parameter Problem"
    If pIPe.status = 11016 Then RCode = "Source Quench"
    If pIPe.status = 11017 Then RCode = "Option too Big"
    If pIPe.status = 11018 Then RCode = " Bad Destination"
    If pIPe.status = 11019 Then RCode = "Address Deleted"
    If pIPe.status = 11020 Then RCode = "Spec MTU Change"
    If pIPe.status = 11021 Then RCode = "MTU Change"
    If pIPe.status = 11022 Then RCode = "Unload"
    If pIPe.status = 11050 Then RCode = "General Failure"
    RCode = RCode + " (" + CStr(pIPe.status) + ")"

    DoEvents
    If TraceRT = False Then
    
        If pIPe.status = 0 Then
            Text3.Text = Text3.Text + "  Reply from " + RespondingHost + ": Bytes = " + Trim$(CStr(pIPe.DataSize)) + " RTT = " + Trim$(CStr(pIPe.RoundTripTime)) + "ms TTL = " + Trim$(CStr(pIPe.Options.TTL)) + Chr$(13) + Chr$(10)
        Else
            Text3.Text = Text3.Text + "  Reply from " + RespondingHost + ": " + RCode + Chr$(13) + Chr$(10)
        End If

    Else
        If TTL - 1 < 10 Then Text3.Text = Text3.Text + "  Hop # 0" + CStr(TTL - 1) Else Text3.Text = Text3.Text + "  Hop # " + CStr(TTL - 1)
        Text3.Text = Text3.Text + "  " + RespondingHost + Chr$(13) + Chr$(10)
    End If

End Sub
Function HiByte(ByVal wParam As Integer)

    HiByte = wParam \ &H100 And &HFF&

End Function
Function LoByte(ByVal wParam As Integer)

    LoByte = wParam And &HFF&

End Function
Sub vbGetHostByName()

    Dim szString As String

    Host = Trim$(Text1.Text)               ' Set Variable Host to Value in Text1.text

    szString = String(64, &H0)
    Host = Host + Right$(szString, 64 - Len(Host))

    If gethostbyname(Host) = SOCKET_ERROR Then              ' If WSock32 error, then tell me about it
        sMsg = "Winsock Error" & Str$(WSAGetLastError())
        'MsgBox sMsg, vbOKOnly, "VB4032-ICMPEcho"
    Else
        PointerToPointer = gethostbyname(Host)              ' Get the pointer to the address of the winsock hostent structure
        CopyMemory Hostent.h_name, ByVal _
        PointerToPointer, Len(Hostent)                      ' Copy Winsock structure to the VisualBasic structure

        ListAddress = Hostent.h_addr_list                   ' Get the ListAddress of the Address List
        CopyMemory ListAddr, ByVal ListAddress, 4           ' Copy Winsock structure to the VisualBasic structure
        CopyMemory IPLong, ByVal ListAddr, 4                ' Get the first list entry from the Address List
        CopyMemory Addr, ByVal ListAddr, 4

        Label3.Caption = Trim$(CStr(Asc(IPLong.Byte4)) + "." + CStr(Asc(IPLong.Byte3)) _
            + "." + CStr(Asc(IPLong.Byte2)) + "." + CStr(Asc(IPLong.Byte1)))
    End If

End Sub
Sub vbGetHostName()
    
    Host = String(64, &H0)          ' Set Host value to a bunch of spaces
    
    If gethostname(Host, HostLen) = SOCKET_ERROR Then     ' This routine is where we get the host's name
        sMsg = "WSock32 Error" & Str$(WSAGetLastError())  ' If WSOCK32 error, then tell me about it
        'MsgBox sMsg, vbOKOnly, "VB4032-ICMPEcho"
    Else
        Host = Left$(Trim$(Host), Len(Trim$(Host)) - 1)   ' Trim up the results
        Text1.Text = Host                                 ' Display the host's name in label1
    End If

End Sub
Sub vbIcmpCreateFile()

    hIP = IcmpCreateFile()

    If hIP = 0 Then
        MsgBox "Unable to Create File Handle", vbOKOnly, "VBPing32"
    End If

End Sub
Sub vbIcmpSendEcho()

    Dim NbrOfPkts As Integer

    szBuffer = "abcdefghijklmnopqrstuvwabcdefghijklmnopqrstuvwabcdefghijklmnopqrstuvwabcdefghijklmnopqrstuvwabcdefghijklmnopqrstuvwabcdefghijklm"

    If IsNumeric(Text5.Text) Then
        If Val(Text5.Text) < 32 Then Text5.Text = "32"
        If Val(Text5.Text) > 128 Then Text5.Text = "128"
    Else
        Text5.Text = "32"
    End If

    szBuffer = Left$(szBuffer, Val(Text5.Text))

    If IsNumeric(Text4.Text) Then
        If Val(Text4.Text) < 1 Then Text4.Text = "1"
    Else
        Text4.Text = "1"
    End If

    If TraceRT = True Then Text4.Text = "1"

    For NbrOfPkts = 1 To Trim$(Text4.Text)

        DoEvents
        bReturn = IcmpSendEcho(hIP, Addr, szBuffer, Len(szBuffer), pIPo, pIPe, Len(pIPe) + 8, 2700)

        If bReturn Then

            RespondingHost = CStr(pIPe.Address(0)) + "." + CStr(pIPe.Address(1)) + "." + CStr(pIPe.Address(2)) + "." + CStr(pIPe.Address(3))

            GetRCode

        Else        ' I hate it when this happens.  If I get an ICMP timeout
                    ' during a TRACERT, try again.

            If TraceRT Then
                TTL = TTL - 1
            Else    ' Don't worry about trying again on a PING, just timeout
                Text3.Text = Text3.Text + "ICMP Request Timeout" + Chr$(13) + Chr$(10)
            End If

        End If

    Next NbrOfPkts

End Sub

Sub vbWSACleanup()

    ' Subroutine to perform WSACleanup

    iReturn = WSACleanup()

    If iReturn <> 0 Then       ' If WSock32 error, then tell me about it.
        sMsg = "WSock32 Error - " & Trim$(Str$(iReturn)) & " occurred in Cleanup"
        MsgBox sMsg, vbOKOnly, "VB4032-ICMPEcho"
        End
    End If

End Sub
Sub vbWSAStartup()
    
    ' Subroutine to Initialize WSock32

    iReturn = WSAStartup(&H101, WSAdata)

    If iReturn <> 0 Then    ' If WSock32 error, then tell me about it
        MsgBox "WSock32.dll is not responding!", vbOKOnly, "VB4032-ICMPEcho"
    End If

    If LoByte(WSAdata.wVersion) < WS_VERSION_MAJOR Or (LoByte(WSAdata.wVersion) = WS_VERSION_MAJOR And HiByte(WSAdata.wVersion) < WS_VERSION_MINOR) Then
        sHighByte = Trim$(Str$(HiByte(WSAdata.wVersion)))
        sLowByte = Trim$(Str$(LoByte(WSAdata.wVersion)))
        
        sMsg = "WinSock Version " & sLowByte & "." & sHighByte
        sMsg = sMsg & " is not supported "
        MsgBox sMsg, vbOKOnly, "VB4032-ICMPEcho"
        End
    End If

    If WSAdata.iMaxSockets < MIN_SOCKETS_REQD Then
        sMsg = "This application requires a minimum of "
        sMsg = sMsg & Trim$(Str$(MIN_SOCKETS_REQD)) & " supported sockets."
        MsgBox sMsg, vbOKOnly, "VB4032-ICMPEcho"
        End
    End If
    
    MaxSockets = WSAdata.iMaxSockets

    '  WSAdata.iMaxSockets is an unsigned short, so we have to convert it to a signed long

    If MaxSockets < 0 Then
        MaxSockets = 65536 + MaxSockets
    End If

    MaxUDP = WSAdata.iMaxUdpDg
    If MaxUDP < 0 Then
        MaxUDP = 65536 + MaxUDP
    End If

    '  Process the Winsock Description information
 
    description = ""

    For i = 0 To WSADESCRIPTION_LEN
        If WSAdata.szDescription(i) = 0 Then Exit For
        description = description + Chr$(WSAdata.szDescription(i))
    Next i

    '  Process the Winsock Status information

    status = ""

    For i = 0 To WSASYS_STATUS_LEN
        If WSAdata.szSystemStatus(i) = 0 Then Exit For
        status = status + Chr$(WSAdata.szSystemStatus(i))
    Next i

End Sub

Private Sub Timer1_Timer()

End Sub

Private Sub Command1_Click()
   Text3.Text = ""
    vbWSAStartup               ' Initialize Winsock

    If Len(Text1.Text) = 0 Then
        vbGetHostName
    End If

    If Text1.Text = "" Then
        MsgBox "No Hostname Specified!", vbOKOnly, "VB4032-ICMPEcho"    ' Complain if No Host Name Identified
        vbWSACleanup
        Exit Sub
    End If

    vbGetHostByName            ' Get the IPAddress for the Host

    vbIcmpCreateFile           ' Get ICMP Handle

    ' The following determines the TTL of the ICMPEcho

    If IsNumeric(Text2.Text) Then
        If (Val(Text2.Text) > 255) Then Text2.Text = "255"
        If (Val(Text2.Text) < 2) Then Text2.Text = "2"
    Else
        Text2.Text = "255"
    End If

    pIPo.TTL = Trim$(Text2.Text)

    vbIcmpSendEcho             ' Send the ICMP Echo Request

    vbIcmpCloseHandle          ' Close the ICMP Handle

    vbWSACleanup               ' Close Winsock

End Sub

Private Sub Command2_Click()
Text3.Text = ""

End Sub

Private Sub Command3_Click()

    Text3.Text = ""

    vbWSAStartup               ' Initialize Winsock

    If Len(Text1.Text) = 0 Then
        vbGetHostName
    End If

    If Text1.Text = "" Then
        MsgBox "No Hostname Specified!", vbOKOnly, "VB4032-ICMPEcho"    ' Complain if No Host Name Identified
        vbWSACleanup
        Exit Sub
    End If

    vbGetHostByName            ' Get the IPAddress for the Host

    vbIcmpCreateFile           ' Get ICMP Handle
    
    
    ' The following determines the TTL of the ICMPEcho for TRACE function

    TraceRT = True

    Text3.Text = Text3.Text + "Tracing Route to " + Label3.Caption + ":" + Chr$(13) + Chr$(10) + Chr$(13) + Chr$(10)

    For TTL = 2 To 255

        pIPo.TTL = TTL

        vbIcmpSendEcho             ' Send the ICMP Echo Request
        DoEvents

        If RespondingHost = Label3.Caption Then

            Text3.Text = Text3.Text + Chr$(13) + Chr$(10) + "Route Trace has Completed" + Chr$(13) + Chr$(10) + Chr$(13) + Chr$(10)

            Exit For        ' Stop TraceRT

        End If

    Next TTL

    TraceRT = False

    vbIcmpCloseHandle          ' Close the ICMP Handle

    vbWSACleanup               ' Close Winsock

End Sub


Private Sub Command4_Click()
Unload Me
End
End Sub


Private Sub Form_Load()
    ' I have, on many occasions, found the need to be able to perform
    ' a Ping function from within Visual Basic.  There are a few OCX
    ' Controls available on the market, however, they all require the
    ' ability for the WinSock stack to support SOCK_RAW.

    ' Microsoft does not support Raw Sockets on any of their WinSock1.1
    ' stacks.  It also appears that it will not be supported on the
    ' Winsock2.0 stack for Windows95.

    ' Raw Sockets, however, is supported on NT4.0.

    ' Microsoft, due to the lack of support of Raw Sockets, created the
    ' ICMP.DLL in order to perform basic ICMP functions such as PING and
    ' TRACERT.

    ' Well, I have finally figured out how to use the ICMP.DLL from Visual
    ' Basic.  There are not additives and no preservatives.

    ' This program is provided as is, without any warranties.  I am providing
    ' it freely.  I designed it on Windows95, however, I am sure it will work
    ' on NT3.51.  if you use portions of this code, please include some sort
    ' of reference to the author.

    ' This program was created by Jim Huff of Edinborg Productions.

    ' If you have any questions, you can reach me at:

    ' jimhuff@shentel.net
    ' edinborg@shentel.net
End Sub


