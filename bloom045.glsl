// source: https://gist.github.com/qwerasd205/c3da6c610c8ffe17d6d2d3cc7068f17f
// credits: https://github.com/qwerasd205
// Golden spiral samples, [x, y, weight] weight is inverse of distance.
const vec3[24] samples = {
  vec3(0.1693761725038636, 0.9855514761735895, 1),
  vec3(-1.333070830962943, 0.4721463328627773, 0.7071067811865475),
  vec3(-0.8464394909806497, -1.51113870578065, 0.5773502691896258),
  vec3(1.554155680728463, -1.2588090085709776, 0.5),
  vec3(1.681364377589461, 1.4741145918052656, 0.4472135954999579),
  vec3(-1.2795157692199817, 2.088741103228784, 0.4082482904638631),
  vec3(-2.4575847530631187, -0.9799373355024756, 0.3779644730092272),
  vec3(0.5874641440200847, -2.7667464429345077, 0.35355339059327373),
  vec3(2.997715703369726, 0.11704939884745152, 0.3333333333333333),
  vec3(0.41360842451688395, 3.1351121305574803, 0.31622776601683794),
  vec3(-3.167149933769243, 0.9844599011770256, 0.30151134457776363),
  vec3(-1.5736713846521535, -3.0860263079123245, 0.2886751345948129),
  vec3(2.888202648340422, -2.1583061557896213, 0.2773500981126146),
  vec3(2.7150778983300325, 2.5745586041105715, 0.2672612419124244),
  vec3(-2.1504069972377464, 3.2211410627650165, 0.2581988897471611),
  vec3(-3.6548858794907493, -1.6253643308191343, 0.25),
  vec3(1.0130775986052671, -3.9967078676335834, 0.24253562503633297),
  vec3(4.229723673607257, 0.33081361055181563, 0.23570226039551587),
  vec3(0.40107790291173834, 4.340407413572593, 0.22941573387056174),
  vec3(-4.319124570236028, 1.159811599693438, 0.22360679774997896),
  vec3(-1.9209044802827355, -4.160543952132907, 0.2182178902359924),
  vec3(3.8639122286635708, -2.6589814382925123, 0.21320071635561041),
  vec3(3.3486228404946234, 3.4331800232609, 0.20851441405707477),
  vec3(-2.8769733643574344, 3.9652268864187157, 0.20412414523193154)
  };

float lum(vec4 c) {
  return 0.299 * c.r + 0.587 * c.g + 0.114 * c.b;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;

  vec4 color = texture(iChannel0, uv);

  vec2 step = vec2(1.414) / iResolution.xy;

  for (int i = 0; i < 24; i++) {
    vec3 s = samples[i];
    vec4 c = texture(iChannel0, uv + s.xy * step);
    float l = lum(c);
    if (l > 0.2) {
      color += l * s.z * c * 0.045;
    }
  }

  fragColor = color;
}
