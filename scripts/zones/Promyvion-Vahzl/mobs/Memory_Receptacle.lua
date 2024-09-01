-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Memory Receptacle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.promyvion.receptacleOnMobInitialize(mob)
end

entity.onMobSpawn = function(mob)
    xi.promyvion.receptacleOnMobSpawn(mob)
end

entity.onMobRoam = function(mob)
    xi.promyvion.receptacleOnMobRoam(mob)
end

entity.onMobEngage = function(mob, target)
    xi.promyvion.receptacleOnMobEngage(mob)
end

entity.onMobFight = function(mob, target)
    xi.promyvion.receptacleOnMobFight(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    xi.promyvion.receptacleOnMobWeaponSkill(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.promyvion.receptacleOnMobDeath(mob, optParams)
end

entity.onMobDespawn = function(mob)
    xi.promyvion.receptacleOnMobDespawn(mob)
end

return entity
