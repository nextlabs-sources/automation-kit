#!/bin/python

import xlrd
  
def read_excel_file(workbook, worksheet, firstCol=1, firstRow=2):
    wb = xlrd.open_workbook(workbook)
    sheet = wb.sheet_by_name(worksheet)
    
    row = firstRow
    keyCol = firstCol
    xpathCol = firstCol + 1
    dataDict = {}
    try:
        while True:
            key = sheet.cell_value(row, keyCol)
            value = sheet.cell_value(row, xpathCol)
            if not key:
                break
            dataDict[key] = value
            row += 1
    except:
        print("Last excel row reached")
    return dataDict

if __name__ == "__main__":
    read_excel_file('C:/Program Files/NextLabs/Code/cc-ui-test/testdata/Control Center/Xpaths.xls', 'Console_Login')
