#pragma once
#include "../../client/client.h"
#include "../../client/minimap.h"
#include "common/c_converter.h"




class NativeMiniMap
{
public:
	static void native_show(Minimap *m, Client *c);
	static void native_hide(Minimap *m, Client *c);
	//check about returns, datatypes confusing
	static v3s16 native_get_pos(Minimap *m);
	static v3s16 native_set_pos(Minimap *m, v3s16 pos);

	static int native_get_angle(Minimap *m);
	static int native_set_angle(Minimap *m, f32 angle);

	static int native_get_mode(Minimap *m);
	static void native_set_mode(Minimap *m, int mode);

	static int native_get_shape(Minimap *m);
	static int native_set_shape(Minimap *m, int shapeNum);
};