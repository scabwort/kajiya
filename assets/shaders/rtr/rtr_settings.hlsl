// Rendering RTR NOT scaled by FG allows denosing of just the light values,
// and means that the darkening caused by FG is temporally responsive.
// OTOH, it also causes bright lines to appear in corners of some objects,
// and those are amplified in motion.
//
// HACK: must be 1 if jointly filtering with specular lighting
#define RTR_RENDER_SCALED_BY_FG 0

#define RTR_RAY_HIT_STORED_AS_POSITION 1

// Only works with `RTR_RAY_HIT_STORED_AS_POSITION` set to true.
// At 0.0 uses the center pixel's position when calculating the ray direction for a neighbor sample.
// At 1.0 uses the neighbor position. This amounts to `RTR_RAY_HIT_STORED_AS_POSITION` being false.
// In theory, this should be 0.0, but in practice that causes many hits to be consistencly rejected in corners,
// biasing the average ray direction away from the corner, and causing apparent leaks when the surround is bright,
// but the nearby object is dark.
//
// Note: if non-zero, RTR_MEASURE_CONVERSION_CLAMP_ATTENUATION must be true for ReSTIR reflections.
#define RTR_NEIGHBOR_RAY_ORIGIN_CENTER_BIAS 0.5

// Technically should not be clamped, but clamping reduces some excessive hotness
// in corners on smooth surfaces, which is a good trade of the slight darkening this causes.
#define RTR_MEASURE_CONVERSION_CLAMP_ATTENUATION true

#define RTR_PDF_STORED_WITH_SURFACE_AREA_METRIC 0

// If true, only uses distance^2 for conversion between projected solid angle and surface area.
// Skipping the cosine terms is certainly not correct, but the effect is small considering
// that neighbors with dissimilar normals are rejected in the first place.
// The artifacts from this are slight leaking of spec within the sample reuse kernel on the reflecting
// surface, beind the plane of a surface receiving light.
//
// Has slightly visible line artifacts when `RTR_NEIGHBOR_RAY_ORIGIN_CENTER_BIAS` is zero.
// Has visible artifacts on edges when used with ReSTIR
#define RTR_APPROX_MEASURE_CONVERSION 0

#define RTR_ROUGHNESS_CLAMP 6e-4

// Lower values clean up dark splotches in presence of high frequency
// roughness variation, but they also dim down spec highlights therein.
#define RTR_RESTIR_MAX_PDF_CLAMP 200

#define RTR_USE_TEMPORAL_FILTERS 1
