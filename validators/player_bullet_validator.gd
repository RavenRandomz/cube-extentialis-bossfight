extends Validator

func validate(body: Object):
	if (body is BasicBullet):
		var bullet:BasicBullet = body
		return bullet.get_source() is Player
