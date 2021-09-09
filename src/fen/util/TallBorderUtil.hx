package fen.util;

@:dox(hide)
class TallBorderUtil {
    public static function printHeaderTall() {
        Sys.println("┌─┬─┬─┬─┬─┬─┬─┬─┐");
    }

    public static function printLineTall(row:String):Void {
        Sys.println("│" + row.charAt(0) + "│" + row.charAt(1) + "│" + row.charAt(2) + "│" + row.charAt(3) +
        "│" + row.charAt(4) + "│" + row.charAt(5) + "│" + row.charAt(6) + "│" + row.charAt(7) + "│");
    }

    public static function printSpacerTall() {
        Sys.println("├─┼─┼─┼─┼─┼─┼─┼─┤");
    }

    public static function printFooterTall() {
        Sys.println("└─┴─┴─┴─┴─┴─┴─┴─┘");
    }

    public static function removeTallBorder(visualization:String):String {
        var onlyFieldContents:String = "";
        var charCounter:Int = 0;
        while (charCounter < visualization.length) {
            var currentChar = visualization.charAt(charCounter);
            if (CharFunctions.isLetter(currentChar) || currentChar == " ") {
                onlyFieldContents += currentChar;
            }
            ++charCounter;
        }
        charCounter = 0;
        var borderlessVisualization:String = "";
        while (charCounter < onlyFieldContents.length) {
            borderlessVisualization += onlyFieldContents.charAt(charCounter);
            if ((charCounter + 1) % 8 == 0) {
                borderlessVisualization += "\n";
            }
            ++charCounter;
        }
        borderlessVisualization = borderlessVisualization.substring(0, (borderlessVisualization.length - 1));
        return borderlessVisualization;
    }
}
