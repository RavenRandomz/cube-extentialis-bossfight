class_name BulletSourceManager extends Node

var _bullet_sources:Array[BasicBulletSource] = []

func _init(bullet_sources:Array[BasicBulletSource]):
    _bullet_sources = bullet_sources

func fire_all():
    for source in _bullet_sources:
        source.fire()

func start_continous_fire_all():
    for source in _bullet_sources:
        source.start_continuous_fire()

func stop_continuous_fire_all():
    for source in _bullet_sources:
        source.stop_continous_fire()