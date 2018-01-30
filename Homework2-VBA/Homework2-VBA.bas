Attribute VB_Name = "Module1"

Sub StockTickerHard()

Dim ws As Worksheet
For Each ws In ActiveWorkbook.Worksheets
 
  Dim Ticker As String
  Dim OpenValue As Double
  Dim CloseValue As Double
  Dim Volume As Double
  Volume = 0
  Dim Yearly As Double
  Dim Percent As Double
  Dim Counter As Integer
  Counter = 0
  Dim Table_Row As Integer
  Table_Row = 2

LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row


ws.Range("J1").Value = "Ticker"
ws.Range("K1").Value = "Year Change"
ws.Range("L1").Value = "Percent Change"
ws.Range("M1").Value = "Total Stock Volume"

  For i = 2 To LastRow

    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

      Ticker = ws.Cells(i, 1).Value

      Volume = Volume + ws.Cells(i, 7).Value

      ws.Range("J" & Table_Row).Value = Ticker
      ws.Range("K" & Table_Row).Value = Volume
      
      Initial_cell = i - Counter
      OpenValue = ws.Range("C" & Initial_cell).Value
      CloseValue = ws.Range("F" & i).Value
      Yearly = CloseValue - OpenValue
      
      If OpenValue <> 0 Then
      Percent = Yearly / OpenValue
      Else: Percent = 0
      End If
      
      ws.Range("L" & Table_Row).Value = Yearly
      ws.Range("L" & Table_Row).NumberFormat = "$0.00"
      ws.Range("M" & Table_Row).Value = Percent
      ws.Range("M" & Table_Row).NumberFormat = "0.00%"
            
        If Yearly > 0 Then
        ws.Range("L" & Table_Row).Interior.ColorIndex = 4 'Green
        Else
        ws.Range("L" & Table_Row).Interior.ColorIndex = 3 ' Red
        End If
      
      Counter = 0
      Table_Row = Table_Row + 1
      Volume = 0

    Else

      Volume = Volume + ws.Cells(i, 7).Value
      Counter = Counter + 1

    End If

  Next i

'This is the part that compiles the Max, Min and Percentage

Dim Max As Double
Dim Min As Double
Dim MaxPct As Double

    Max = WorksheetFunction.Max(ws.Range("M:M"))
    ws.Cells(2, 17).Value = Max
    ws.Cells(2, 17).NumberFormat = "0.00%"
     
    Min = WorksheetFunction.Min(ws.Range("M:M"))
    ws.Cells(3, 17).Value = Min
    ws.Cells(3, 17).NumberFormat = "0.00%"
    
    MaxPct = WorksheetFunction.Max(ws.Range("K:K"))
    ws.Cells(4, 17).Value = MaxPct
    
ws.Range("P1").Value = "Ticker"
ws.Range("Q1").Value = "Value"
ws.Range("O2").Value = "Greates % Incresase"
ws.Range("O3").Value = "Greatest % Decrease"
ws.Range("O4").Value = "Greatest Total Volume"

LastRow2 = ws.Cells(Rows.Count, 10).End(xlUp).Row

For i = 2 To LastRow2

If ws.Cells(i, 13).Value <> Max Then
Else:
ws.Cells(2, 16).Value = ws.Cells(i, 10).Value
End If

If ws.Cells(i, 13).Value <> Min Then
      Else:
      ws.Cells(3, 16).Value = ws.Cells(i, 10).Value
      End If
    
If ws.Cells(i, 11).Value <> MaxPct Then
      Else:
      ws.Cells(4, 16).Value = ws.Cells(i, 10).Value
      End If
      
Next i

Next ws
End Sub


