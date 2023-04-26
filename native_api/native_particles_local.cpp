#include "native_particles_local.h"
#include "common/c_content.h"
#include "common/c_converter.h"
#include "lua_api/l_internal.h"
#include "lua_api/l_object.h"
#include "client/particles.h"
#include "client/client.h"
#include "client/clientevent.h"

int NativeApiParticlesLocal::native_add_particle(Client *_client, v3f *_pos,
		v3f *_vel, v3f *_acc,
		float *_expirationtime, float *_size,
		bool *_collisiondetection, bool *_collision_removal,
		bool *_vertical, TileAnimationParams *_animation,
		std::string *_texture, u8 *_glow,
		MapNode *_node, irr::u8 *_nodeTile)
{
	// Get parameters
	ParticleParameters p;

	p.pos = (_pos != nullptr) ? *_pos : v3f(0, 0, 0);
	p.vel = (_vel != nullptr) ? *_vel : v3f(0, 0, 0);
	p.acc = (_acc != nullptr) ? *_acc : v3f(0, 0, 0);

	p.expirationtime = (_expirationtime != nullptr) ? *_expirationtime : 1.0f;
	p.size = (_size != nullptr) ? *_size : 1.0f;

	p.collisiondetection = (_collisiondetection != nullptr) ? *_collisiondetection : false;
	p.collision_removal = (_collision_removal != nullptr) ? *_collision_removal : false;
	p.vertical = (_vertical != nullptr) ? *_vertical : false;

	struct TileAnimationParams animation = *_animation;
	animation.type = TAT_NONE;
	p.animation = animation;

	p.texture = (_texture != nullptr) ? *_texture : "";
	p.glow = (_glow != nullptr) ? *_glow : 0;

	p.node = (_node != nullptr) ? *_node : *(new MapNode());

	p.node_tile = (_nodeTile != nullptr) ? *_nodeTile : 0;

	ClientEvent *event = new ClientEvent();
	event->type = CE_SPAWN_PARTICLE;
	event->spawn_particle = new ParticleParameters(p);

	_client->pushToEventQueue(event);

	return 0;
}

u64 NativeApiParticlesLocal::native_add_particlespawner(Client *_client, u16 *_amount,
		v3f *_minpos, v3f *_maxpos,
		v3f *_minvel, v3f *_maxvel,
		v3f *_minacc, v3f *_maxacc,
		float *_time, float *_minexptime,
		float *_maxexptime, float *_minsize,
		float *_maxsize, bool *_collisiondetection,
		bool *_vertical, bool *_collision_removal,
		TileAnimationParams *_animation, std::string *_texture, u8 *_glow,
		MapNode *_node, irr::u8 *_nodeTile)
{
	// Get parameters
	ParticleSpawnerParameters p;

	p.amount = (_amount != nullptr) ? *_amount : 1;
	p.time = (_time != nullptr) ? *_time : 1.0f;

	p.minpos = (_minpos != nullptr) ? *_minpos : v3f(0, 0, 0);
	p.maxpos = (_maxpos != nullptr) ? *_maxpos : v3f(0, 0, 0);
	p.minvel = (_minvel != nullptr) ? *_minvel : v3f(0, 0, 0);
	p.maxvel = (_maxvel != nullptr) ? *_maxvel : v3f(0, 0, 0);
	p.minacc = (_minacc != nullptr) ? *_minacc : v3f(0, 0, 0);
	p.maxacc = (_maxacc != nullptr) ? *_maxacc : v3f(0, 0, 0);

	p.minexptime = (_minexptime != nullptr) ? *_minexptime : 1.0f;
	p.maxexptime = (_maxexptime != nullptr) ? *_maxexptime : 1.0f;
	p.minsize = (_minsize != nullptr) ? *_minsize : 1.0f;
	p.maxsize = (_maxsize != nullptr) ? *_maxsize : 1.0f;
	p.collisiondetection = (_collisiondetection != nullptr) ? *_collisiondetection : false;
	p.collision_removal = (_collision_removal != nullptr) ? *_collision_removal : false;
	p.vertical = (_vertical != nullptr) ? *_vertical : false;

	struct TileAnimationParams animation = *_animation;
	animation.type = TAT_NONE;
	p.animation = animation;

	p.vertical = (_vertical != nullptr) ? *_vertical : false;
	p.texture = (_texture != nullptr) ? *_texture : "";
	p.glow = (_glow != nullptr) ? *_glow : 0;

	p.node = (_node != nullptr) ? *_node : *(new MapNode());

	p.node_tile = (_nodeTile != nullptr) ? *_nodeTile : 0;

	u64 id = _client->getParticleManager()->generateSpawnerId();

	auto event = new ClientEvent();
	event->type = CE_ADD_PARTICLESPAWNER;
	event->add_particlespawner.p = new ParticleSpawnerParameters(p);
	event->add_particlespawner.attached_id = 0;
	event->add_particlespawner.id = id;
	
	_client->pushToEventQueue(event);

	return id;
}

int NativeApiParticlesLocal::native_delete_particlespawner(u32 _id, Client *_client)
{
	// Get parameters
	ClientEvent *event = new ClientEvent();
	event->type = CE_DELETE_PARTICLESPAWNER;
	event->delete_particlespawner.id = _id;

	_client->pushToEventQueue(event);
	return 0;
}