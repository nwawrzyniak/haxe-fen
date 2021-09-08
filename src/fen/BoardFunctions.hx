package fen;

import fen.deps.util.*;
import fen.deps.exceptions.*;

/**
* Supplies functions to build and/or print a board representation from a FEN record string, object or field placement.
*
* This class is only intended to be used in conjunction with normal 8x8 chess boards.
*
* This class is not intended for other boards, e.g. the one used in Double Chess or Capablanca chess.
*
* If you think an important feature is missing, please consider making a pull request.
**/
class BoardFunctions {
    /**
    * Returns a board reprsentation string that contains 8 times 8 characters in dextrograd order from White's
    * perspective (starting with A8 in the upper left), separated by LF ("\n").
    *
    * If fieldPlacement is not valid, the result is unspecified.
    *
    * @param fieldPlacement the field placement portion of a FEN record.
    **/
    public static function buildBoardFromFieldPlacement(fieldPlacement:String):String {
        // The board representation which is filled and returned
        var board:String = "";

        // The index of the currently handled character in fieldPlacement.
        var charCounter:Int = 0;
        while (charCounter < fieldPlacement.length) {
            var currentChar:String = fieldPlacement.charAt(charCounter);
            if (CharFunctions.isLetter(currentChar)) {
                board += currentChar;
            } else if (CharFunctions.isNumeric(currentChar)) {
                var spaceCounter = Std.parseInt(currentChar);
                while (spaceCounter > 0) {
                    board += " ";
                    --spaceCounter;
                }
            } else if (currentChar == "/") {
                board += "\n";
            } else {
                throw new IllegalCharacterException("Illegal character: " + currentChar);
            }
            ++charCounter;
        }
        return board;
    }

    /**
    * Returns a board reprsentation string that contains 8 times 8 characters in dextrograd order from White's
    * perspective (starting with A8 in the upper left), separated by LF ("\n").
    *
    * If the FEN object was created from invalid inputs, the result is unspecified.
    *
    * @param fEN any FEN object.
    **/
    public static function buildBoardFromFENObject(fEN:FEN):String {
        return buildBoardFromFieldPlacement(fEN.getFieldPlacement());
    }

    /**
    * Returns a board reprsentation string that contains 8 times 8 characters in dextrograd order from White's
    * perspective (starting with A8 in the upper left), separated by LF ("\n").
    *
    * If the FEN record fENString is invalid, the result is unspecified.
    *
    * @param fENString any FEN record.
    **/
    public static function buildBoardFromFENString(fENString:String):String {
        return buildBoardFromFieldPlacement(new FEN(fENString).getFieldPlacement());
    }

    /**
    * Returns the field placement portion usable in FEN record strings from a visualization.
    *
    * If no borderMode is specified, BorderMode.OFF is used.
    *
    * If visualization is invalid, the result is mostly unspecified.
    *
    * If the visualization has data for more than eight rows an UnexpectedRowAmountException is thrown.
    *
    * If borderMode is invalid an UnknownBorderModeException is thrown.
    *
    * @param visualization  A String representing all fields of the board in dextrograd order from White's perspective.
    * It needs to be LF separated (\n) after every row (therefore after every eight characters).
    * @param borderMode The BorderMode the visualization was created with.
    **/
    public static function createFieldPlacementFromBoardString(visualization:String,
                                                               ?borderMode:BorderMode):String {
        var fieldPlacement:String = "";
        if (borderMode == null || borderMode == BorderMode.OFF) {
            var rows:Array<String> = visualization.split("\n");
            for (row in rows) {
                var charCounter:Int = 0;
                var skipCounter = 0;
                while (charCounter < row.length) {
                    var currentChar:String = row.charAt(charCounter);
                    if (CharFunctions.isLetter(currentChar)) {
                        if (skipCounter > 0) {
                            fieldPlacement += "" + skipCounter;
                            skipCounter = 0;
                        }
                        fieldPlacement += currentChar;
                        ++charCounter;
                    } else if (currentChar == " ") {
                        ++skipCounter;
                        ++charCounter;
                    } else throw new IllegalCharacterException("Illegal character: " + currentChar);
                    if ((charCounter == row.length) && (skipCounter > 0)) {
                        fieldPlacement += "" + skipCounter;
                    }
                }
                fieldPlacement += "/";
            }
            fieldPlacement = fieldPlacement.substring(0, (fieldPlacement.length - 1));
        } else if (borderMode == BorderMode.TALL) {
            return createFieldPlacementFromBoardString(
                        TallBorderUtil.removeTallBorder(visualization), BorderMode.OFF);
        } else throw new UnknownBorderModeException("Unknown BorderMode: " + borderMode);
        return fieldPlacement;
    }

    /**
    * Prints a visualization of the board from a board string.
    *
    * If board is invalid the result is unspecified.
    *
    * If borderMode is not specified this function behaves as if BorderMode.OFF was specified.
    *
    * @param board  A String representing all fields of the board in dextrograd order from White's perspective.
    * It needs to be LF separated (\n) after every row (therefore after every eight characters).
    * @param borderMode any border mode.
    **/
    public static function printBoard(board:String, ?borderMode:BorderMode):Void {
        if (borderMode == null || borderMode == BorderMode.OFF) Sys.println(board);
        else if (borderMode == BorderMode.TALL) {
            var rows:Array<String> = board.split("\n");
            var rowCount:Int = 0;
            var charCount:Int = 0;
            for (row in rows) {
                if (rowCount == 0) {
                    TallBorderUtil.printHeaderTall();
                    TallBorderUtil.printLineTall(row);
                } else if (rowCount >= 1 && rowCount <= 6) {
                    TallBorderUtil.printSpacerTall();
                    TallBorderUtil.printLineTall(row);
                } else if (rowCount == 7) {
                    TallBorderUtil.printSpacerTall();
                    TallBorderUtil.printLineTall(row);
                    TallBorderUtil.printFooterTall();
                } else throw new UnexpectedRowAmountException("Too many rows.");
                ++rowCount;
            }
        } else throw new UnknownBorderModeException("Unknown BorderMode: " + borderMode);
    }

    /**
    * Prints a visualization of the board from a the field placement portion of a FEN record.
    *
    * If fieldPlacement is invalid the result is unspecified.
    *
    * If borderMode is not specified this function behaves as if BorderMode.OFF was specified.
    *
    * @param fieldPlacement Any valid field placement portion of a FEN record.
    * @param borderMode any border mode.
    **/
    public static function printBoardFromFieldPlacement(fieldPlacement:String, ?borderMode:BorderMode):Void {
        printBoard(buildBoardFromFieldPlacement(fieldPlacement), borderMode);
    }

    /**
    * Prints a visualization of the board from a FEN object.
    *
    * If the field placement portion of fEN is invalid the result is unspecified.
    *
    * If borderMode is not specified this function behaves as if BorderMode.OFF was specified.
    *
    * @param fEN    Any valid FEN object.
    * @param borderMode any border mode.
    **/
    public static function printBoardFromFENObject(fEN:FEN, ?borderMode:BorderMode):Void {
        printBoardFromFieldPlacement(fEN.getFieldPlacement(), borderMode);
    }

    /**
    * Prints a visualization of the board from a FEN record string.
    *
    * If fENString is invalid the result is unspecified.
    *
    * If borderMode is not specified this function behaves as if BorderMode.OFF was specified.
    *
    * @param fENString  Any valid FEN record string.
    * @param borderMode any border mode.
    **/
    public static function printBoardFromFullFENString(fENString:String, ?borderMode:BorderMode):Void {
        printBoardFromFieldPlacement(new FEN(fENString).getFieldPlacement(), borderMode);
    }
}
