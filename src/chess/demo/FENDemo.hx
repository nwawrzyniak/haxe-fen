package chess.demo;

import chess.fen.*;

/**
* This is a full demonstration of the capabilities of the fen library for chess related software in Haxe.
*
* To understand the fen library you can either read though the comments or just run the Demo and check the command
* line output.
**/
@:dox(hide)
class FENDemo {
    /**
    * The main function of the Demo.
    *
    * Shows a lot of function calls in practice.
    **/
    public static function main() {
        /*
         *  1) Storing and accessing FEN data.
         */

        // preparation: set any FEN record string
        var fENString:String = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";

        // create a FEN object from a FEN record string
        var fen1:FEN = new FEN(fENString);
        trace("The FEN record was:\n" + fen1.getFENString());

        // create a FEN object from its six components. Note that the halfmove clock and the fullmove number are Int.
        var fen2:FEN = FEN.createFENFromComponents("rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R", "b", "KQkq",
                "-", 1, 2);
        trace("The second FEN record created by specifying its six fields was:\n" + fen2.getFENString());

        // extract the field placement from the FEN object
        var fieldPlacement:String = fen1.getFieldPlacement();
        trace("The field placement portion of the FEN record is:\n" + fieldPlacement);

        // extract the active color from the FEN object
        var activeColor:String = fen1.getActiveColor();
        trace("The active color portion of the FEN record is:\n" + activeColor);

        // extract the castling availability from the FEN object
        var castlingAvailability:String = fen1.getCastlingAvailability();
        trace("The castling availability portion of the FEN record is:\n" + castlingAvailability);

        // extract the en passant target square from the FEN object
        var enPassant:String = fen1.getEnPassant();
        trace("The en passant portion of the FEN record is:\n" + enPassant);

        // extract the halfmove clock from the FEN object
        var halfmoveClock:Int = fen1.getHalfmoveClock();
        trace("The halfmove clock portion of the FEN record is:\n" + halfmoveClock);

        // extract the fullmove number from the FEN object
        var fullmoveNumber:Int = fen1.getFullmoveNumber();
        trace("The fullmove number portion of the FEN record is:\n" + fullmoveNumber + "\n");

        /*
            2) Printing visualizations.
            They can be created via any of 4 different functions, taking different inputs.
         */

        trace("There are 4 different functions to create a visualization from anything that contains " +
                "sufficient field placement information:");

        // create a visualization from a board string
        trace("This is a visualization of the board created by the printBoard() function:");
        BoardFunctions.printBoard(fen1.getBoard());

        // create a visualization from the field placement portion of the FEN record
        trace("This is the same visualization, but created by the printBoardFromFieldPlacement() function:");
        BoardFunctions.printBoardFromFieldPlacement(fieldPlacement);

        // create a visualization from a FEN object
        trace("Next is the same visualization, but created by the printBoardFromFENObject() function:");
        BoardFunctions.printBoardFromFENObject(fen1);

        // create a visualization from a FEN record string
        trace("And fourth is the same visualization, but created by the printBoardFromFullFENString() " +
                "function:");
        BoardFunctions.printBoardFromFullFENString(fENString);

        trace("As you can see, all 4 functions create the exact same board representation, just from " +
                "different inputs.\n");

        // create a visualization from a FEN record string with the "TALL" BorderMode
        trace("Next, the optional BorderMode is shown.\nThis is, again, the visualization created by " +
                "printBoardFromFullFENString(), but with an appending BorderMode.TALL:");
        BoardFunctions.printBoardFromFullFENString(fENString, BorderMode.TALL);

        trace("Not specifying any BorderMode defaults to BorderMode.OFF\n");

        /*
            3) Serializing/Deserializing to and from .fen files.
         */

        #if sys
        trace("You can also serialize any FEN record to a file.");
        var fen1FileName:String = "initial_position";
        var fen2FileName:String = "other_position";
        trace("Uncomment the line after this to serialize fen1 to a file in the project root.");
        // fen1.serialize(".", fen1FileName);
        var fenDirectory:String = ".fen";
        var fenExtension:String = ".fen";
        var home = Sys.getEnv(if (Sys.systemName() == "Windows") "UserProfile" else "HOME");
        trace("Uncomment the block after this line to serialize fen2 to a file in a new directory \".fen\" in the " +
                "user home directory.");
        /*
        if (!sys.FileSystem.exists(home + "/" + fenDirectory)) {
            sys.FileSystem.createDirectory(home + "/" + fenDirectory);
        }
        fen2.serialize(home + "/" + fenDirectory, fen2FileName);
        */
        trace("Conversely, you can unserialize (load) any FEN file (usually ending with .fen) to a FEN object.\n");
        var file1:String = "./" + fen1FileName + fenExtension;
        if (sys.FileSystem.exists(file1)) {
            trace("The following is the content loaded from ./" + fen1FileName + fenExtension + ":");
            trace(FEN.deserialize(file1).getFENString());
        }
        var file2:String = home + "/" + fenDirectory + "/" + fen2FileName + fenExtension;
        if (sys.FileSystem.exists(file2)) {
            trace("The following is the content loaded from " + home + "/" + fenDirectory + "/" + fen2FileName +
                    fenExtension + ":");
            trace(FEN.deserialize(file2).getFENString() + "\n");
        }
        #else
        trace("This function only works on targets which support the sys API.\n");
        #end

        /*
            4) Creating FEN record strings, FEN objects and field placement portions of a FEN record from adequate
            representations or visualizations created with this library.
         */

        trace("Lastly, there is the creation of the field placement portion for a FEN record from a visualization.\n" +
                "If the visualization has a border, the BorderMode needs to be specified.\n" +
                "If the visualization has no border, this can be omitted.\n" +
                "The following 3 FEN records are created with different BorderMode arguments specified.");

        // create the field placement portion of a FEN record from a visualization
        var boardGeneratedFieldPlacement:String = BoardFunctions.createFieldPlacementFromBoardString(fen1.getBoard());
        trace("This is the result of createFieldPlacementFromBoardString() with no BorderMode specified:");
        trace(boardGeneratedFieldPlacement);

        // create the field placement portion of a FEN record from a visualization with BorderMode.OFF
        var boardGeneratedFieldPlacementModeOff:String = BoardFunctions.createFieldPlacementFromBoardString(
                fen1.getBoard(), BorderMode.OFF);
        trace("This is the result of createFieldPlacementFromBoardString() with BorderMode.OFF:");
        trace(boardGeneratedFieldPlacementModeOff);

        // create the field placement portion of a FEN record from a visualization with BorderMode.TALL
        var boardGeneratedFieldPlacementModeTall:String = BoardFunctions.createFieldPlacementFromBoardString(
            getTestBoardWithTallBorder(), BorderMode.TALL);
        trace("This is the result of createFieldPlacementFromBoardString() with BorderMode.TALL:");
        trace(boardGeneratedFieldPlacementModeTall);
    }

    /**
    * Returns a manually created test board with the default chess starting position with the "TALL" BorderMode.
    *
    * This is used to test the function `BoardFunctions.createFieldPlacementFromBoardString(board:String,
    * BorderMode.TALL)`.
    **/
    @:dox(hide)
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
