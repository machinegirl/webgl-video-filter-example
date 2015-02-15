/*
	A GLSL video filter example which uses webcam and microphone input.
	
	Copyright 2015 Jeremy Carter (Jeremy@JeremyCarter.ca)
	Copyright 2015 Daphne Volante (Daphne.volante@eternalvoid.net)
	
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
	
	float n = 0.5;
	
	float rgb = (r+g+b)/3.0;
	
	float rg = (r + g)/2.0;
	float rb = (r + b)/2.0;
	float gb = (g + b)/2.0;

	
	float avgmaxfreq = (uMaxFreq + uMaxFreq2 + uMaxFreq3)/3.0;
	
	if (rgb < 0.16 && uMaxFreq > n) {            	
		r += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		g += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		b += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);

		r -= abs(1.0 - ((float(uMaxFreq2Loc))/64.0));
		g -= uMaxFreq2 / abs(32.0 - float(uMaxFreqLoc));
		b -= uMaxFreq2 * (float(uMaxFreq2Loc)/6.4);
		
		r += uMaxFreq3 * (float(uMaxFreq3Loc)/32.0);
		g += uMaxFreq3 - (abs(32.0 - float(uMaxFreq3Loc))/32.0);
		b += uMaxFreq3 / 1.0 - (float(uMaxFreq3Loc)/64.0);
	} else if (rgb > 0.159 && rgb < 0.32 && uMaxFreq > n) {
		g += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		b += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		r += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);

		g -= abs(1.0 - ((float(uMaxFreq2Loc))/64.0));
		b -= uMaxFreq2 / abs(32.0 - float(uMaxFreqLoc));
		r -= uMaxFreq2 * (float(uMaxFreq2Loc)/6.4);

		g += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		b += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		r += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);
	} else if (rgb > 0.319 && rgb < 0.48 && uMaxFreq > n) {
		b += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		r += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		g += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);

		b -= abs(1.0 - ((float(uMaxFreq2Loc))/64.0));
		r -= uMaxFreq2 / abs(32.0 - float(uMaxFreqLoc));
		g -= uMaxFreq2 * (float(uMaxFreq2Loc)/6.4);

		b += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		r += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		g += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);
	} else if (rgb > 0.479 && rgb < 0.64 && uMaxFreq > n) {
		r += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		b += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		g += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);

		r -= abs(1.0 - ((float(uMaxFreq2Loc))/64.0));
		b -= uMaxFreq2 / abs(32.0 - float(uMaxFreqLoc));
		g -= uMaxFreq2 * (float(uMaxFreq2Loc)/6.4);

		r += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		b += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		g += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);
	} else if (rgb > 0.639 && rgb < 0.8 && uMaxFreq > n) {
		b += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		g += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		r += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);

		b -= abs(1.0 - ((float(uMaxFreq2Loc))/64.0));
		g -= uMaxFreq2 / abs(32.0 - float(uMaxFreqLoc));
		r -= uMaxFreq2 * (float(uMaxFreq2Loc)/6.4);

		b += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		g += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		r += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);
	} else if (rgb > 0.799 && uMaxFreq > n) {
		g += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		r += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		b += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);

		g -= abs(1.0 - ((float(uMaxFreq2Loc))/64.0));
		r -= uMaxFreq2 / abs(32.0 - float(uMaxFreqLoc));
		b -= uMaxFreq2 * (float(uMaxFreq2Loc)/6.4);

		g += uMaxFreq * (float(uMaxFreqLoc)/32.0);
		r += uMaxFreq - (abs(32.0 - float(uMaxFreqLoc))/32.0);
		b += uMaxFreq / 1.0 - (float(uMaxFreqLoc)/64.0);
	}

	
	r /= 2.0;
	g /= 2.0;
	b /= 2.0;


	if (rg > color.b && avgmaxfreq > n) {
		r += avgmaxfreq;
		r /= 2.0;
	} else if (rb > color.g && avgmaxfreq > n) {
		b += avgmaxfreq;
		b /= 2.0;
	} else if (gb > color.r && avgmaxfreq > n) {
		g += avgmaxfreq;
		g /= 2.0;
	}

	
	r = clamp(r, 0.0, 1.0);
	g = clamp(g, 0.0, 1.0);
	b = clamp(b, 0.0, 1.0);
	a = clamp(a, 0.0, 1.0);
	
	return vec4(r, g, b, a);
}

void main() {
	
	vec4 color = texture2D(tDiffuse, vUv);
	color = filter1(color);
	gl_FragColor = color;
}
