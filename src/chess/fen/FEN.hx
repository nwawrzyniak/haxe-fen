package chess.fen;

/**
* Represents a FEN record object.
**/
class FEN {
    // Implementation details and comments are taken from Wikipedia:
    // https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation

    /**
    * Piece placement (from White's perspective). Each rank is described, starting with rank 8 and ending with rank 1;
    * within each rank, the contents of each square are described from file "a" through file "h". Following the Standard
    * Algebraic Notation (SAN), each piece is identified by a single letter taken from the standard English names
    * (pawn = "P", knight = "N", bishop = "B", rook = "R", queen = "Q" and king = "K"). White pieces are designated
    * using upper-case letters ("PNBRQK") while black pieces use lowercase ("pnbrqk"). Empty squares are noted using
    * digits 1 through 8 (the number of empty squares), and "/" separates ranks.
    **/
    var fieldPlacement:String;

    /**
    * Active color. "w" means White moves next, "b" means Black moves next.
    **/
    var activeColor:String;

    /**
    * Castling availability. If neither side can castle, this is "-". Otherwise, this has one or more letters: "K"
    * (White can castle kingside), "Q" (White can castle queenside), "k" (Black can castle kingside), and/or "q" (Black
    * can castle queenside). A move that temporarily prevents castling does not negate this notation.
    **/
    var castlingAvailability:String;

    /**
    * En passant target square in algebraic notation. If there's no en passant target square, this is "-". If a pawn has
    * just made a two-square move, this is the position "behind" the pawn. This is recorded regardless of whether there
    * is a pawn in position to make an en passant capture.
    **/
    var enPassant:String;

    /**
    * Halfmove clock: The number of halfmoves since the last capture or pawn advance, used for the fifty-move rule.
    **/
    var halfmoveClock:Int;

    /**
    * Fullmove number: The number of the full move. It starts at 1, and is incremented after Black's move.
    **/
    var fullmoveNumber:Int;

    /**
    * Constructor. Creates a new FEN object from a FEN string.
    *
    * If `fENString` is invalid the result is unspecified.
    *
    * @param fENString  Any valid FEN record.
    **/
    public function new(fENString:String) {
        var sixFields:Array<String> = split(fENString);
        fieldPlacement = sixFields[0];
        activeColor = sixFields[1];
        castlingAvailability = sixFields[2];
        enPassant = sixFields[3];
        halfmoveClock = Std.parseInt(sixFields[4]);
        fullmoveNumber = Std.parseInt(sixFields[5]);
    }

    /**
    * Second constructor to create a FEN object from the six component fields of a FEN record.
    *
    * If any value is null the result is unspecified.
    *
    * @param fieldPlacement Piece placement (from White's perspective). Each rank is described, starting with rank 8
    * and ending with rank 1; within each rank, the contents of each square are described from file "a" through
    * file "h". Following the Standard Algebraic Notation (SAN), each piece is identified by a single letter taken
    * from the standard English names (pawn = "P", knight = "N", bishop = "B", rook = "R", queen = "Q" and king = "K").
    * White pieces are designated using upper-case letters ("PNBRQK") while black pieces use lowercase ("pnbrqk").
    * Empty squares are noted using digits 1 through 8 (the number of empty squares), and "/" separates ranks.
    * @param activeColor    Active color. "w" means White moves next, "b" means Black moves next.
    * @param castlingAvailability   Castling availability. If neither side can castle, this is "-". Otherwise, this
    * has one or more letters: "K" (White can castle kingside), "Q" (White can castle queenside), "k" (Black can
    * castle kingside), and/or "q" (Black can castle queenside). A move that temporarily prevents castling does not
    * negate this notation.
    * @param enPassant  En passant target square in algebraic notation. If there's no en passant target square, this
    * is "-". If a pawn has just made a two-square move, this is the position "behind" the pawn. This is recorded
    * regardless of whether there is a pawn in position to make an en passant capture.
    * @param halfmoveClock  Halfmove clock: The number of halfmoves since the last capture or pawn advance, used for
    * the fifty-move rule.
    * @param fullmoveNumber Fullmove number: The number of the full move. It starts at 1, and is incremented after
    * Black's move.
    **/
    public static function createFENFromComponents(fieldPlacement:String, activeColor:String,
                                                   castlingAvailability:String, enPassant:String, halfmoveClock:Int,
                                                   fullmoveNumber:Int):FEN {
        return new FEN(fieldPlacement + " " + activeColor + " " + castlingAvailability + " " + enPassant + " " +
                halfmoveClock + " " + fullmoveNumber);
    }

    /**
    * Splits a FEN record string at its specified delimiter " " (whitespace).
    *
    * Returns an `Array<String>` containing the six individual fields of the FEN record.
    *
    * `split(fENString)[0]` contains `fieldPlacement`.
    *
    * `split(fENString)[1]` contains `activeColor`.
    *
    * `split(fENString)[2]` contains `castlingAvailability`.
    *
    * `split(fENString)[3]` contains `enPassant`.
    *
    * `split(fENString)[4]` contains `halfmoveClock`.
    *
    * `split(fENString)[5]` contains `fullmoveNumber`.
    *
    * For invalid FEN records the result is unspecifed.
    *
    * @param fENString  Any valid FEN record.
    **/
    public function split(fENString:String):Array<String> {
        return fENString.split(" ");
    }

    /**
    * Returns the full FEN record string of the FEN object.
    **/
    public function getFENString():String {
        return '$fieldPlacement $activeColor $castlingAvailability $enPassant $halfmoveClock $fullmoveNumber';
    }

    /**
    * Returns a string representation of the full board in dextrograd order.
    *
    * White pieces are depicted as upper case letters, black pieces as lower case letters.
    *
    * Empty fields are depicted as spaces, not with a number.
    *
    * Rows are seperated by "\n" (LF).
    **/
    public function getBoard():String {
        return BoardFunctions.buildBoardFromFieldPlacement(fieldPlacement);
    }

    /**
    * Returns the field placement portion of the FEN record.
    **/
    public function getFieldPlacement():String {
        return fieldPlacement;
    }

    /**
    * Replaces the field placement portion of the FEN object.
    *
    * @param fieldPlacement the new field placement.
    **/
    public function setFieldPlacement(fieldPlacement:String):Void {
        this.fieldPlacement = fieldPlacement;
    }

    /**
    * Returns the active color portion of the FEN record.
    **/
    public function getActiveColor():String {
        return activeColor;
    }

    /**
    * Replaces the active color portion of the FEN object.
    *
    * @param activeColor the new active color.
    **/
    public function setActiveColor(activeColor:String):Void {
        this.activeColor = activeColor;
    }

    /**
    * Returns the castling availability portion of the FEN record.
    **/
    public function getCastlingAvailability():String {
        return castlingAvailability;
    }

    /**
    * Replaces the castling availability portion of the FEN object.
    *
    * @param castlingAvailability the new castling availability value.
    **/
    public function setCastlingAvailability(castlingAvailability:String):Void {
        this.castlingAvailability = castlingAvailability;
    }

    /**
    * Returns the en passant target square portion of the FEN record.
    **/
    public function getEnPassant():String {
        return enPassant;
    }

    /**
    * Replaces the en passant target square portion of the FEN object.
    *
    * @param enPassant the new en passant target sqaure value.
    **/
    public function setEnPassant(enPassant:String):Void {
        this.enPassant = enPassant;
    }

    /**
    * Returns the halfmove clock portion of the FEN record.
    **/
    public function getHalfmoveClock():Int {
        return halfmoveClock;
    }

    /**
    * Replaces the halfmove clock portion of the FEN object.
    *
    * @param halfmoveClock the new halfmove clock value.
    **/
    public function setHalfmoveClock(halfmoveClock:Int):Void {
        this.halfmoveClock = halfmoveClock;
    }

    /**
    * Returns the fullmove number portion of the FEN record.
    **/
    public function getFullmoveNumber():Int {
        return fullmoveNumber;
    }

    /**
    * Replaces the fullmove number portion of the FEN object.
    *
    * @param fullmoveNumber the new fullmove number.
    **/
    public function setFullmoveNumber(fullmoveNumber:Int):Void {
        this.fullmoveNumber = fullmoveNumber;
    }

    /**
    * Serializes the FEN object to a `.fen` file.
    *
    * Works only for sys targets.
    * Read more about sys targets here https://haxe.org/manual/std-sys.html.
    *
    * @param filePath the file to save to, either as relative or absolute path, with file extension.
    **/
    public function serialize(filePath:String):Void {
        #if sys
        sys.io.File.saveContent(filePath, getFENString());
        return;
        #else
        trace("This function only works on targets which support the sys package.");
        #end
    }

    /**
    * Creates a FEN object from a `.fen` file.
    *
    * Works only for sys targets.
    * Read more about sys targets here https://haxe.org/manual/std-sys.html.
    *
    * For illegal input files, the result is mostly unspecified.
    *
    * If the file specified in `filePath` does not exist, `null` is returned.
    *
    * If the target language does not support the sys API, `null` is returned.
    *
    * @param filePath the file to load, either as relative or absolute path, with file extension.
    **/
    public static function deserialize(filePath:String):FEN {
        #if sys
        if (sys.FileSystem.exists(filePath)) {
            return new FEN(sys.io.File.getContent(filePath));
        }
        return null;
        #else
        trace("This function only works on targets which support the sys API.");
        return null;
        #end
    }
}
