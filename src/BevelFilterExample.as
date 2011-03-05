package openscape{
    import flash.display.Sprite;
    import flash.filters.BevelFilter;
    import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.BitmapFilterType;

    public class BevelFilterExample extends Sprite {
        private var bgColor:uint = 0xFFCC00;
        private var size:uint    = 80;
        private var offset:uint  = 50;

        public function BevelFilterExample() {
            draw();
            var filter:BitmapFilter = getBitmapFilter();
            var myFilters:Array = new Array();
            myFilters.push(filter);
            filters = myFilters;
        }

        private function getBitmapFilter():BitmapFilter {
            var distance:Number       = 5;
            var angleInDegrees:Number = 45;
            var highlightColor:Number = 0xFFFF00;
            var highlightAlpha:Number = 0.8;
            var shadowColor:Number    = 0x0000FF;
            var shadowAlpha:Number    = 0.8;
            var blurX:Number          = 5;
            var blurY:Number          = 5;
            var strength:Number       = 5;
            var quality:Number        = BitmapFilterQuality.HIGH;
            var type:String           = BitmapFilterType.INNER;
            var knockout:Boolean      = false;

            return new BevelFilter(distance,
                                   angleInDegrees,
                                   highlightColor,
                                   highlightAlpha,
                                   shadowColor,
                                   shadowAlpha,
                                   blurX,
                                   blurY,
                                   strength,
                                   quality,
                                   type,
                                   knockout);
        }

        private function draw():void {
            graphics.beginFill(bgColor);
            graphics.drawRect(offset, offset, size, size);
            graphics.endFill();
        }
    }
}