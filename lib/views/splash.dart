part of views;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() {
    return _SplashState();
  }
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController _fadeOutAnimation;

  void initState() {
    super.initState();
    _fadeOutAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
  }

  Widget _textAnimation({Widget text, AnimationController controller}) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: controller, curve: Curves.easeIn),
      child: text,
    );
  }

  Widget _title() {
    Widget _titleText() {
      AnimationController _titleAnimation = AnimationController(
        duration: Duration(milliseconds: 1500),
        vsync: this,
      );
      return _textAnimation(
          text: Text(
            "Every Day",
            style: Theme.of(context).textTheme.headline2,
          ),
          controller: _titleAnimation..forward());
    }

    Widget _subTitleText() {
      AnimationController _subTitleAnimation = AnimationController(
        duration: Duration(milliseconds: 1500),
        vsync: this,
      );
      Future.delayed(Duration(milliseconds: 500))
          .then((value) => _subTitleAnimation.forward());
      return _textAnimation(
          text: Text(
            "Bible",
            style: Theme.of(context).textTheme.headline2.copyWith(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold),
          ),
          controller: _subTitleAnimation);
    }

    return Align(
      alignment: Alignment(-0.7, -0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleText(),
          _subTitleText(),
        ],
      ),
    );
  }

  Widget _button() {
    AnimationController _btnAnimation = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    Provider.of<BibleController>(context)
        .init()
        .whenComplete(() => _btnAnimation.forward());

    return Align(
      alignment: Alignment(0.8, 0.7),
      child: Stack(
        alignment: Alignment.center,
        children: [
          FadeTransition(
            opacity: Tween<double>(begin: 1, end: 0).animate(_btnAnimation),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          ),
          FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(_btnAnimation),
            child: GestureDetector(
                onTap: () async {
                  await _fadeOutAnimation.forward();
                  Get.to(() => EveryDayBible(),
                      transition: Transition.fade,
                      duration: Duration(microseconds: 1000));
                },
                child: Text("Amen")),
          )
        ],
      ),
    );
  }

  Widget _copyRight() {
    AnimationController _copyrightAnimation = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    Future.delayed(Duration(milliseconds: 700))
        .whenComplete(() => _copyrightAnimation.forward());

    return Align(
      alignment: Alignment(0, 0.9),
      child: _textAnimation(
        text: Text(
          "Copyright © 2018 Scripture Union Korea. All rights reserved.",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.brown.shade300, fontSize: 10),
        ),
        controller: _copyrightAnimation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Get.theme.primaryColorLight.withOpacity(0.7),
            Get.theme.primaryColorDark,
          ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        ),
        child: FadeTransition(
          opacity:
              Tween<double>(begin: 1.0, end: 0.0).animate(_fadeOutAnimation),
          child: Stack(
            children: [
              _title(),
              _button(),
              _copyRight(),
            ],
          ),
        ),
      ),
    );
  }
}
