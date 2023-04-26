#include "native_camera.h"
#include <cmath>
#include "client/content_cao.h"
#include <tuple>
#include "client/camera.h"
#include "client/client.h"

int NativeCamera::native_set_camera_mode(Camera *camera, Client *client, int val)
{
	GenericCAO *playercao = client->getEnv().getLocalPlayer()->getCAO();
	sanity_check(playercao);

	camera->setCameraMode((CameraMode)(val));
	playercao->setVisible(camera->getCameraMode() > CAMERA_MODE_FIRST);
	playercao->setChildrenVisible(camera->getCameraMode() > CAMERA_MODE_FIRST);

	return 0;
}

int NativeCamera::native_get_camera_mode(Camera *camera)
{
	int camMode = (int)camera->getCameraMode();

	return camMode;
}

std::tuple<f32, f32, f32, f32> NativeCamera::native_get_fov(Camera *camera)
{
	f32 x = camera->getFovX() * core::RADTODEG;
	f32 y = camera->getFovY() * core::RADTODEG;
	f32 actual = camera->getCameraNode()->getFOV() * core::RADTODEG;
	f32 max = camera->getFovMax() * core::RADTODEG;

	return std::tuple<f32, f32, f32, f32>(x, y, actual, max);
}

v3f NativeCamera::native_get_pos(Camera *camera)
{
	v3f position = camera->getPosition() / BS;

	return position;
}

v3f NativeCamera::native_get_offset(Client *client)
{
	LocalPlayer *player = client->getEnv().getLocalPlayer();
	sanity_check(player);
	
	v3f offset = player->getEyeOffset() / BS;

	return offset;
}

v3f NativeCamera::native_get_look_dir(Camera *camera)
{
	v3f lookDir = camera->getDirection();

	return lookDir;
}

f32 NativeCamera::native_get_look_horizontal(Client *client)
{
	LocalPlayer *player = client->getEnv().getLocalPlayer();
	sanity_check(player);

	f32 lookHorizontal = (player->getYaw() + 90.f) * core::DEGTORAD;

	return lookHorizontal;
}

f32 NativeCamera::native_get_look_vertical(Client *client)
{
	LocalPlayer *player = client->getEnv().getLocalPlayer();
	sanity_check(player);

	f32 lookVertical = -1.0f * player->getPitch() * core::DEGTORAD;

	return lookVertical;
}

f32 NativeCamera::native_get_aspect_ratio(Camera *camera)
{
	f32 aspectRatio = camera->getCameraNode()->getAspectRatio();

	return aspectRatio;
}