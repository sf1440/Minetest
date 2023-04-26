#include "native_particles.h"

int NativeApiParticles::native_add_particle(Server *_server, v3f *_pos,
		v3f *_vel, v3f *_acc,
		float *_expirationtime, float *_size,
		bool *_collisiondetection, bool *_collision_removal,
		bool *_object_collision, bool *_vertical,
		TileAnimationParams *_animation, std::string *_texture,
		std::string *_playername, u8 *_glow,
		MapNode *_node, irr::u8 *_nodeTile)
{
	// Get parameters
	struct ParticleParameters p;

	p.pos = (_pos != nullptr) ? *_pos : v3f(0, 0, 0);
	p.vel = (_vel != nullptr) ? *_vel : v3f(0, 0, 0);
	p.acc = (_acc != nullptr) ? *_acc : v3f(0, 0, 0);

	p.expirationtime = (_expirationtime != nullptr) ? *_expirationtime : 1.0f;
	p.size = (_size != nullptr) ? *_size : 1.0f;
	p.collisiondetection = (_collisiondetection != nullptr) ? *_collisiondetection : false;
	p.collision_removal = (_collision_removal != nullptr) ? *_collision_removal : false;
	p.object_collision = (_object_collision != nullptr) ? *_object_collision : false;
	p.vertical = (_vertical != nullptr) ? *_vertical : false;

	struct TileAnimationParams animation = *_animation;
	animation.type = TAT_NONE;
	p.animation = animation;

	p.texture = (_texture != nullptr) ? *_texture : "";
	u8 glow = (_glow != nullptr) ? *_glow : 0;

	p.node = (_node != nullptr) ? *_node : *(new MapNode());

	p.node_tile = (_nodeTile != nullptr) ? *_nodeTile : 0;

	std::string playername = (_playername != nullptr) ? *_playername : "";

	_server->spawnParticle(playername, p);
	return 0;
}

u32 NativeApiParticles::native_add_particlespawner(Server *_server, u16 *_amount,
		v3f *_minpos, v3f *_maxpos,
		v3f *_minvel, v3f *_maxvel,
		v3f *_minacc, v3f *_maxacc,
		float *_time, float *_minexptime,
		float *_maxexptime, float *_minsize,
		float *_maxsize, bool *_collisiondetection,
		bool *_collision_removal, bool *_object_collision,
		bool *_vertical, TileAnimationParams *_animation,
		std::string *_texture, ServerActiveObject *_attached,
		std::string *_playername, u8 *_glow,
		MapNode *_node, irr::u8 *_nodeTile)
{
	// Get parameters
	ParticleSpawnerParameters p;

	p.amount = (_amount != nullptr) ? *_amount : 1;
	p.time = (_time != nullptr) ? *_time : 0;

	p.minpos = (_minpos != nullptr) ? *_minpos : v3f(0, 0, 0);
	p.maxpos = (_maxpos != nullptr) ? *_maxpos : v3f(0, 0, 0);
	p.minvel = (_minvel != nullptr) ? *_minvel : v3f(0, 0, 0);
	p.maxvel = (_maxvel != nullptr) ? *_maxvel : v3f(0, 0, 0);
	p.minacc = (_minacc != nullptr) ? *_minacc : v3f(0, 0, 0);
	p.maxacc = (_maxacc != nullptr) ? *_maxacc : v3f(0, 0, 0);

	p.time = (_time != nullptr) ? *_time : 1.0f;
	p.minexptime = (_minexptime != nullptr) ? *_minexptime : 1.0f;
	p.maxexptime = (_maxexptime != nullptr) ? *_maxexptime : 1.0f;
	p.minsize = (_minsize != nullptr) ? *_minsize : 1.0f;
	p.maxsize = (_maxsize != nullptr) ? *_maxsize : 1.0f;
	p.collisiondetection = (_collisiondetection != nullptr) ? *_collisiondetection : false;
	p.collision_removal = (_collision_removal != nullptr) ? *_collision_removal : false;
	p.object_collision = (_object_collision != nullptr) ? *_object_collision : false;

	struct TileAnimationParams animation = *_animation;
	animation.type = TAT_NONE;
	p.animation = animation;

	ServerActiveObject *attached = (_attached != nullptr) ? _attached : NULL;

	p.vertical = (_vertical != nullptr) ? *_vertical : false;
	p.texture = (_texture != nullptr) ? *_texture : "";
	std::string playername = (_playername != nullptr) ? *_playername : "";
	p.glow = (_glow != nullptr) ? *_glow : 0;

	p.node = (_node != nullptr) ? *_node : *(new MapNode());

	p.node_tile = (_nodeTile != nullptr) ? *_nodeTile : 0;


	u32 id = _server->addParticleSpawner(p, attached, playername);

	return id;
}

int NativeApiParticles::native_delete_particlespawner(u32 _id, std::string _playername, Server *_server)
{
	_server->deleteParticleSpawner(_playername, _id);
	return 0;
}