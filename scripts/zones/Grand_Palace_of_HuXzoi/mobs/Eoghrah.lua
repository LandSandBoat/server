-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'ghrah
-----------------------------------
mixins = { require('scripts/mixins/families/ghrah') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobRoam = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
