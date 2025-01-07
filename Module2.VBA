Attribute VB_Name = "Module1"
Sub StockAnalysis()

'First we want to Loop through all worksheets in the workbook
    For Each ws In ThisWorkbook.Worksheets

'Then we gotta set our variables!
    Dim Ticker As String
    Dim QuarterlyChange As Double
    Dim PercentChange As Double
    Dim TotalVolume As Double
    Dim LastRow As Long
    Dim SummaryRow As Long
    Dim OpeningPrice As Double
    Dim ClosingPrice As Double

'Then you want to make column headers for your summary table
    ws.Cells(1, 10) = "Ticker"
    ws.Cells(1, 11) = "Quarterly Change"
    ws.Cells(1, 12) = "Percent Change"
    ws.Cells(1, 13) = "Total Stock Volume"

'Then we need to find the last row of data in the worksheet
   LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

' Now to set your initial summary table row
    SummaryRow = 2

' Let's loop through all rows of data!
    For i = 2 To LastRow

' Now let's check ticker symbol has changed
    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

' Then let's fetch the ticker symbol
    Ticker = ws.Cells(i, 1).Value

' Then the opening price
    OpeningPrice = ws.Cells(i, 3).Value

' Then the closing price
    ClosingPrice = ws.Cells(i, 6).Value

' Now let's calculate the Quarterly Change
    QuarterlyChange = ClosingPrice - OpeningPrice

' Calculate the percent change
    If OpeningPrice <> 0 Then
    PercentChange = (QuarterlyChange / OpeningPrice) * 100
    Else
    PercentChange = 0
    End If

' Now for the fun part, let's put the Quarterly change, percent change, and total volume into our summary table!
    ws.Cells(SummaryRow, 10).Value = Ticker
    ws.Cells(SummaryRow, 11).Value = QuartlerlyChange
    ws.Cells(SummaryRow, 12).Value = PercentChange
    If i > TotalVolume Then
    ws.Cells(SummaryRow, 13).Value = Application.WorksheetFunction.Sum(ws.Range(ws.Cells(i - TotalVolume + 1, 7), ws.Cells(i, 7)))
Else
    ' Handle the case where i is less than or equal to TotalVolume
    ' For example, sum from the first row to the current row
    Application.WorksheetFunction.Sum (ws.Range(ws.Cells(1, 7), ws.Cells(i, 7)))
End If

'Let's be cordial and format our percent change as percentages
    ws.Cells(SummaryRow, 12).NumberFormat = "0.00%"
'Let's be even more cordial and use conditional formatting for the positive and negative yearly changes
    If QuarterlyChange > 0 Then
    ws.Cells(SummaryRow, 11).Interior.Color = RGB(0, 255, 0)
    ElseIf QuarterlyChange < 0 Then
    ws.Cells(SummaryRow, 11).Interior.Color = RGB(255, 0, 0)
    End If
'Then make sure to set the total volume back to 0
    TotalStockVolume = 0
'Next we want to increment the summary table row to top off our cordial cake
    SummaryRow = SummaryRow + 1
    Else
'ALMOST DONE!!! Now let's add the stock volume to the total volume
    TotalStockVolume = TotalStockVolume + ws.Cells(i, 7).Value
    End If
'To close the first loop!
    Next i
'To close the second loop!
    Next ws
    
'Next Endevour: Find the stock with the greatest percent increase

    Dim Greatestincreaseticker As String
    Dim Greatestincreasechange As Double
    
    For Each ws In ThisWorkbook.Worksheets
    For i = 2 To ws.Cells(Rows.Count, 12).End(xlUp).Row
    If ws.Cells(i, 12).Value > Greatestincreasechange Then
    Greatestincreasechange = ws.Cells(i, 12).Value
    Greatestincreaseticker = ws.Cells(i, 10).Value
    
    End If
    Next i
    Next ws

'Next let's find the stock with the greatest percent decrease
    
    Dim greatestdecreaseticker As String
    Dim greatestdecreasechange As Double
    
    
    
    For Each ws In ThisWorkbook.Worksheets
    For i = 2 To ws.Cells(Rows.Count, 12).End(xlUp).Row
    If ws.Cells(i, 12).Value < greatestdecreasechange Then
    greatestdecreasechange = ws.Cells(i, 12).Value
    greatestdecreaseticker = ws.Cells(i, 10).Value
    
    End If
    Next i
    Next ws
    
'Finally lets find the stock with the greatest total volume

    Dim greatestvolumeticker As String
    Dim greatestvolume As Double

    For Each ws In ThisWorkbook.Worksheets
    For i = 2 To ws.Cells(Rows.Count, 13).End(xlUp).Row
        If ws.Cells(i, 13).Value > greatestvolume Then
            greatestvolume = ws.Cells(i, 13).Value
            greatestvolumeticker = ws.Cells(i, 1).Value
    End If
    Next i
    Next ws


End Sub
