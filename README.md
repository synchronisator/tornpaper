# tornpaper

A Flutter Container that looks like a (maybe torn) paper

# Usage

```
TornPaper(
                key: UniqueKey(),
                backgroundColor: backgroundColor,
                hasNoise: hasNoise,
                noiseColor: noiseColor,
                hasBorder: hasBorder,
                tornWidth: tornWidth,
                tornColor: tornColor,
                tornDeepness: tornDeepness,
                seed: seedValue.toInt(),
                stepWidth: stepWidth,
                hasShadow: hasShadow,
                shadowColor: shadowColor,
                shadowOffset: Offset(shadowOffsetBottom.toDouble(), shadowOffsetRight.toDouble()),
                tornedSides: [
                  if (tornedTop) TornedSide.top,
                  if (tornedRight) TornedSide.right,
                  if (tornedLeft) TornedSide.left,
                  if (tornedBottom) TornedSide.bottom
                ],
                child: [...child...]
          )
```

Most of the variables are self explaining but some are not:

These parameters are changing the "torn"

- seed
- tornwidth
- tornDeepness
- stepWidth

The seed is the Random(seed) for the randomness.

![Torn Explanation](torn_explanation.svg?raw=true "Torn Explanation")

Try all settings on the GithubPage: //TODO

# TODO

- Github Pages
- Github Build/Publish

- BUG: Shadow ab und zu weiß
- BUG: Overflow wenn zu schmal
- BUG: Noise unperformant

# Next Level:
- Tests :D
- Knüll-Optik
- Weiße Abrisskante
- "umschlageeffekt"
