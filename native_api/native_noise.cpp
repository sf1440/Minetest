#include "native_noise.h"
#include "../../noise.h"

Noise *NativeNoise::native_get_2d_map(LuaPerlinNoiseMap *o, v2f pos)
{
	Noise *n = o->getNoise();
	n->perlinMap2D(pos.X, pos.Y);
	return n;
}

std::tuple<Noise*, bool> NativeNoise::native_get_2d_map_flat(LuaPerlinNoiseMap *o, v2f pos, bool buffer)
{
	Noise *n = o->getNoise();
	n->perlinMap2D(pos.X, pos.Y);
	return std::make_tuple(n, buffer);
}

Noise *NativeNoise::native_get_3d_map(LuaPerlinNoiseMap *o, v3f pos)
{
	Noise *n = o->getNoise();
	n->perlinMap3D(pos.X, pos.Y, pos.Z);
	return n;
}

std::tuple<Noise *, bool> NativeNoise::native_get_3d_map_flat(
		LuaPerlinNoiseMap *o, v3f pos, bool buffer)
{
	Noise *n = o->getNoise();
	n->perlinMap3D(pos.X, pos.Y, pos.Z);
	return std::make_tuple(n, buffer);
}

void NativeNoise::native_calc_2d_map(LuaPerlinNoiseMap *o, v2f pos)
{
	Noise *n = o->getNoise();
	n->perlinMap2D(pos.X, pos.Y);
}

void NativeNoise::native_calc_3d_map(LuaPerlinNoiseMap *o, v3f pos)
{
	if (!o->getMis3d())
		return;

	Noise *n = o->getNoise();
	n->perlinMap3D(pos.X, pos.Y, pos.Z);
}

std::tuple <v3u16,v3u16,v3u16, bool> NativeNoise::native_get_map_slice(LuaPerlinNoiseMap *o,
			       v3s16 slice_offset,
		v3s16 slice_size, bool buffer)
{
	Noise *n = o->getNoise();
	auto t = std::make_tuple(v3u16(n->sx, n->sy, n->sz),
			v3u16(slice_offset.X, slice_offset.Y, slice_offset.Z),
			v3u16(slice_size.X, slice_size.Y, slice_size.Z),
		buffer);

	return t;
}

bool NativeNoise::mapis3d(LuaPerlinNoiseMap *o)
{
	if (!o->getMis3d())
		return false;

	return true;
}
