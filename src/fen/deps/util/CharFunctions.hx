package fen.deps.util;

class CharFunctions {
    public static function isLetter(char:String):Bool {
        if (char.length == 1) {
            var charCode:Int = char.charCodeAt(0);
            if ((charCode >= 97 && charCode <= 122) || (charCode >= 65 && charCode <= 90)) {
                return true;
            }
        }
        return false;
    }

    public static function isNumeric(char:String):Bool {
        if (char.length == 1) {
            var charCode:Int = char.charCodeAt(0);
            if (charCode >= 48 && charCode <= 57) {
                return true;
            }
        }
        return false;
    }
}
