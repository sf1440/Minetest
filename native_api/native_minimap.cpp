#include "native_minimap.h"

void NativeMiniMap::native_show(Minimap* m, Client *c)
{
	if (m->getModeIndex() == 0 && m->getMaxModeIndex() > 0)
		m->setModeIndex(1);

	c->showMinimap(true);
}

void NativeMiniMap::native_hide(Minimap* m, Client *c)
{
	c->showMinimap(false);
}

v3s16 NativeMiniMap::native_get_pos(Minimap *m)
{
	return m->getPos();
}

v3s16 NativeMiniMap::native_set_pos(Minimap *m, v3s16 pos)
{
	m->setPos(pos);
	return m->getPos();
	//COME BACK LATER
}

int NativeMiniMap::native_get_angle(Minimap* m)
{
	return m->getAngle();
	//Possible conversion issues between f32 and int?
}

int NativeMiniMap::native_set_angle(Minimap *m, f32 angle)
{
	m->setAngle(angle);
	return 1;
	// COME BACK LATER
}

int NativeMiniMap::native_get_mode(Minimap *m)
{
	return m->getModeIndex();
	//Size_t to int conversion issues?
}

void NativeMiniMap::native_set_mode(Minimap *m, int mode)
{
	m->setModeIndex(mode);
}

int NativeMiniMap::native_get_shape(Minimap *m)
{
	return (int)m->getMinimapShape();
}

//Note (0 = square, 1 = round)

int NativeMiniMap::native_set_shape(Minimap *m, int shapeNum)
{

	m->setMinimapShape((MinimapShape)((int)shapeNum));
	return (int)m->getMinimapShape(); 
	//DO we need a return here?
}