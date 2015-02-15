/*
	A GLSL video filter example which uses webcam and microphone input.
	
	Copyright 2015 Jeremy Carter (Jeremy@JeremyCarter.ca)
	
	Free to use and modify for any purpose, but you must only add additional
	copyright notices and never remove any which were already there (directly above
	this message).
*/

varying vec2 vUv;
uniform sampler2D tDiffuse;
uniform float uAudioData[32];
uniform float uAudioFreq[32];
uniform float uMaxFreq;
uniform float uMaxFreq2;
uniform float uMaxFreq3;
uniform int uMaxFreqLoc;
uniform int uMaxFreq2Loc;
uniform int uMaxFreq3Loc;

float rand(vec2 co, float range) {
	return mod(fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453), range);
}

vec4 filter1(vec4 color) {
	
	float r = color.r;
	float g = color.g;
	float b = color.b;
	float a = color.a;
	
	float rgb = (r+g+b)/2.0;
	
	if (rgb < 0.125 && uMaxFreq > 0.5) {
	r *= uMaxFreq * (float(uMaxFreqLoc)/64.0);
	g *= uMaxFreq2 - (float(uMaxFreq2Loc)/64.0);
	b *= uMaxFreq3 + (float(uMaxFreq3Loc)/64.0);
} else if (rgb > 0.124 && rgb < 0.25 && uMaxFreq > 0.5) {
	r *= uMaxFreq2 - (float(uMaxFreq2Loc)/64.0);
	g *= uMaxFreq3 + (float(uMaxFreq3Loc)/64.0);
	b *= uMaxFreq / (float(uMaxFreqLoc)/64.0);
} else if (rgb > 0.249 && rgb < 0.375 && uMaxFreq > 0.5) {
	r -= uMaxFreq3 + (float(uMaxFreq2Loc)/64.0);
	g -= uMaxFreq / (float(uMaxFreq3Loc)/64.0);
	b -= uMaxFreq2 * (float(uMaxFreqLoc)/64.0);
} else if (rgb > 0.374 && rgb < 0.5 && uMaxFreq > 0.5) {
	r -= uMaxFreq2 / (float(uMaxFreq2Loc)/64.0);
	g -= uMaxFreq3 * (float(uMaxFreq3Loc)/64.0);
	b -= uMaxFreq - (float(uMaxFreqLoc)/64.0);
} else if (rgb > 0.499 && rgb < 0.625 && uMaxFreq > 0.5) {
	r += uMaxFreq2 * (float(uMaxFreq2Loc )/64.0);
	g += uMaxFreq3 + (float(uMaxFreq3Loc)/64.0);
	b += uMaxFreq - (float(uMaxFreqLoc)/64.0);
} else if (rgb > 0.624 && rgb < 0.75 && uMaxFreq > 0.5) {
	r += uMaxFreq2 + (float(uMaxFreq2Loc)/64.0);
	g += uMaxFreq3 - (float(uMaxFreq3Loc)/64.0);
	b += uMaxFreq * (float(uMaxFreqLoc)/64.0);
} else if (rgb > 0.749 && rgb < 0.875 && uMaxFreq > 0.5) {
	r /= uMaxFreq2 - (float(uMaxFreq2Loc)/64.0);
	g /= uMaxFreq3 * (float(uMaxFreq3Loc)/64.0);
	b /= uMaxFreq / (float(uMaxFreqLoc)/64.0);
} else if (rgb > 0.874 && uMaxFreq > 0.5) {
	r /= uMaxFreq2 * (float(uMaxFreq2Loc)/64.0);
	g /= uMaxFreq3 / (float(uMaxFreq3Loc)/64.0);
	b /= uMaxFreq + (float(uMaxFreqLoc)/64.0);
}

	
	float n = 0.55;
	
	
	r /= 2.0;
	g /= 2.0;
	b /= 2.0;
	
	r = mod(r, 1.0);
	g = mod(g, 1.0);
	b = mod(b, 1.0);
	a = clamp(a, 0.0, 1.0);
	
	return vec4(r, g, b, a);
}

void main() {
	
	vec4 color = texture2D(tDiffuse, vUv);
	color = filter1(color);
	gl_FragColor = color;
}
