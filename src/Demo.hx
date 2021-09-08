package ;

import fen.*;

/**
* This is a full demonstration of the capabilities of the fen library for chess related software in Haxe.
*
* To understand the fen library you can either read though the comments or just run the Demo and check the command
* line output.
**/
class Demo {
    static function main() {
        /*
         *  1) Storing and accessing FEN data.
         */

        // preparation: set any FEN record string
        var fENString:String = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";

        // create a FEN object from a FEN record string
        var fen1:FEN = new FEN(fENString);
        Sys.println("The FEN record was:\n" + fen1.getFENString() + "\n");

        // create a FEN object from its six components. Note that the halfmove clock and the fullmove number are Int.
        var fen2:FEN = FEN.createFENFromComponents("rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R", "b", "KQkq",
                "-", 1, 2);
        Sys.println("The second FEN record created by specifying its six fields was:\n" + fen2.getFENString() + "\n");

        // extract the field placement from the FEN object
        var fieldPlacement:String = fen1.getFieldPlacement();
        Sys.println("The field placement portion of the FEN record is:\n" + fieldPlacement + "\n");

        // extract the active color from the FEN object
        var activeColor:String = fen1.getActiveColor();
        Sys.println("The active color portion of the FEN record is:\n" + activeColor + "\n");

        // extract the castling availability from the FEN object
        var castlingAvailability:String = fen1.getCastlingAvailability();
        Sys.println("The castling availability portion of the FEN record is:\n" + castlingAvailability + "\n");

        // extract the en passant target square from the FEN object
        var enPassant:String = fen1.getEnPassant();
        Sys.println("The en passant portion of the FEN record is:\n" + enPassant + "\n");

        // extract the halfmove clock from the FEN object
        var halfmoveClock:Int = fen1.getHalfmoveClock();
        Sys.println("The halfmove clock portion of the FEN record is:\n" + halfmoveClock + "\n");

        // extract the fullmove number from the FEN object
        var fullmoveNumber:Int = fen1.getFullmoveNumber();
        Sys.println("The fullmove number portion of the FEN record is:\n" + fullmoveNumber + "\n");

        /*
            2) Printing visualizations.
            They can be created via any of 4 different functions, taking different inputs.
         */

        Sys.println("There are 4 different functions to create a visualization from anything that contains " +
                "sufficient field placement information:\n");

        // create a visualization from a board string
        Sys.println("This is a visualization of the board created by the printBoard() function:");
        BoardFunctions.printBoard(fen1.getBoard());

        // create a visualization from the field placement portion of the FEN record
        Sys.println("\nThis is the same visualization, but created by the printBoardFromFieldPlacement() function:");
        BoardFunctions.printBoardFromFieldPlacement(fieldPlacement);

        // create a visualization from a FEN object
        Sys.println("\nNext is the same visualization, but created by the printBoardFromFENObject() function:");
        BoardFunctions.printBoardFromFENObject(fen1);

        // create a visualization from a FEN record string
        Sys.println("\nAnd fourth is the same visualization, but created by the printBoardFromFullFENString() " +
                "function:");
        BoardFunctions.printBoardFromFullFENString(fENString);

        Sys.println("\nAs you can see, all 4 functions create the exact same board representation, just from " +
                "different inputs.\n\nNext, the optional BorderMode is shown.\n");

        // create a visualization from a FEN record string with the "TALL" BorderMode
        Sys.println("This is, again, the visualization created by printBoardFromFullFENString(), but with an " +
                "appending BorderMode.TALL");
        BoardFunctions.printBoardFromFullFENString(fENString, BorderMode.TALL);

        Sys.println("\nNot specifying any BorderMode defaults to BorderMode.OFF\n");

        /*
            3) Creating FEN record strings, FEN objects and field placement portions of a FEN record from adequate
            representations or visualizations created with this library.
         */

        Sys.println("Lastly, there is creating the field placement portion for a FEN record from a visualization.\n" +
                "If the visualization had a border, the BorderMode needs to be specified.\n" +
                "If the visualization has no border, this can be omitted.\n" +
                "The following 3 FEN records will all look exactly the same, but the calls used different " +
                "BorderModes.\n");

        // create the field placement portion of a FEN record from a visualization
        var boardGeneratedFieldPlacement:String = BoardFunctions.createFieldPlacementFromBoardString(fen1.getBoard());
        Sys.println("This is the result of createFieldPlacementFromBoardString() with no BorderMode specified:");
        Sys.println(boardGeneratedFieldPlacement + "\n");

        // create the field placement portion of a FEN record from a visualization with BorderMode.OFF
        var boardGeneratedFieldPlacementModeOff:String = BoardFunctions.createFieldPlacementFromBoardString(
                fen1.getBoard(), BorderMode.OFF);
        Sys.println("This is the result of createFieldPlacementFromBoardString() with BorderMode.OFF:");
        Sys.println(boardGeneratedFieldPlacementModeOff + "\n");

        // create the field placement portion of a FEN record from a visualization with BorderMode.TALL
        var boardGeneratedFieldPlacementModeTall:String = BoardFunctions.createFieldPlacementFromBoardString(
            getTestBoardWithTallBorder(), BorderMode.TALL);
        Sys.println("This is the result of createFieldPlacementFromBoardString() with BorderMode.TALL:");
        Sys.println(boardGeneratedFieldPlacementModeTall);
    }

    static function getTestBoardWithTallBorder() {
        return  "┌─┬─┬─┬─┬─┬─┬─┬─┐\n" +
                "│r│n│b│q│k│b│n│r│\n" +
                "├─┼─┼─┼─┼─┼─┼─┼─┤\n" +
                "│p│p│p│p│p│p│p│p│\n" +
                "├─┼─┼─┼─┼─┼─┼─┼─┤\n" +
                "│ │ │ │ │ │ │ │ │\n" +
                "├─┼─┼─┼─┼─┼─┼─┼─┤\n" +
                "│ │ │ │ │ │ │ │ │\n" +
                "├─┼─┼─┼─┼─┼─┼─┼─┤\n" +
                "│ │ │ │ │ │ │ │ │\n" +
                "├─┼─┼─┼─┼─┼─┼─┼─┤\n" +
                "│ │ │ │ │ │ │ │ │\n" +
                "├─┼─┼─┼─┼─┼─┼─┼─┤\n" +
                "│P│P│P│P│P│P│P│P│\n" +
                "├─┼─┼─┼─┼─┼─┼─┼─┤\n" +
                "│R│N│B│Q│K│B│N│R│\n" +
                "└─┴─┴─┴─┴─┴─┴─┴─┘";
    }
}
