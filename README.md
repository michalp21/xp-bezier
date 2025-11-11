# Bezier Animation

Reverse-engineered Windows XP screensavers, **Bezier** and **Mystify**, recreated with p5.js.

**Mystify** is the foundation: line segments connect at anchor points that bounce around the screen.

**Bezier** follows the same concept, but line segments are replaced by cubic Bezier curves whose inner two control points bounce around the screen.

Notes:
- A single higher-order Bezier curve is not the way to go! All those control points smooth out the curve too much and make the animation boring.
- Mystify is technically 2 separate curves with 4 control points each... but I was trying to show the connection lol

# How It Was Made

I trialed Windsurf IDE with a mix of SWE-1.5 for easy prompts and Claude 4.5 for more complex prompts.

The prompt with core Bezier curve logic is below:

> Add a check box to enable "bezier" mode. The joints become control points of a bezier curve. Use p5.js bezierVertex() and look up the documentation to see how to use it properly. Instead of one long bezier curve with many control points (joints), combine many cubic bezier curves where the start point of one is the end point of another. Furthermore, the adjacent control points to the start/end point lie on a line with that start/end point. If curve A has points 1,2,3,4 and curve B has points 1,2,3,4, then A4 is the same as B1, and A3,A4,B2 must be colinear. Likewise A1 is the same as B4, and B3,B4,A2 must be colinear. This must not change even as the points bounce off the edges. Do not apply physics to the connecting point. It is calculated as the midpoint of the two adjacent points

I spent below 100 credits and about 2 hours Windsurfing.