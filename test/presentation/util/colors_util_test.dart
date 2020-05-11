import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty/presentation/util/colors_util.dart';

void main() {

  group('Given a Colors Util', () {
    test('should return right color for position', () async {        
        expect(ColorsUtil.getColorForPosition(0), 0xFF008267);
        expect(ColorsUtil.getColorForPosition(1), 0xFFb6006f);
        expect(ColorsUtil.getColorForPosition(2), 0xFF0097A7);
        expect(ColorsUtil.getColorForPosition(3), 0xFF964df6);
        expect(ColorsUtil.getColorForPosition(4), 0xFF63b4f6);
        expect(ColorsUtil.getColorForPosition(5), 0xFFf357aa);
        expect(ColorsUtil.getColorForPosition(6), 0xFFf8a82e);
        expect(ColorsUtil.getColorForPosition(7), 0xFF607D8B);
        expect(ColorsUtil.getColorForPosition(8), 0xFF388E3C);
        expect(ColorsUtil.getColorForPosition(9), 0xFF00a189);
    });

        test('should return right color for position and ignore dozens', () async {        
        expect(ColorsUtil.getColorForPosition(53), 0xFF964df6);
        expect(ColorsUtil.getColorForPosition(90), 0xFF008267);
        expect(ColorsUtil.getColorForPosition(123), 0xFF964df6);
        expect(ColorsUtil.getColorForPosition(11), 0xFFb6006f);
        expect(ColorsUtil.getColorForPosition(10), 0xFF008267);
    });

  });
}