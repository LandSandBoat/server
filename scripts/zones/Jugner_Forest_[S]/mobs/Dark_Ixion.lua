-----------------------------------
-- Area: Jugner_Forest_[S]
--   NM: Dark Ixion
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.darkixion.onMobInitialize(mob)
end

entity.onMobSpawn = function(mob)
    xi.darkixion.onMobSpawn(mob)
end

entity.onCriticalHit = function(mob, attacker)
    xi.darkixion.onCriticalHit(mob, attacker)
end

entity.onWeaponskillHit = function(mob, attacker, weaponskill)
    xi.darkixion.onWeaponskillHit(mob, attacker, weaponskill)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    xi.darkixion.onMobWeaponSkill(target, mob, skill)
end

entity.onMobRoam = function(mob)
    xi.darkixion.onMobRoam(mob)
end

entity.onMobEngage = function(mob, target)
    xi.darkixion.onMobEngage(mob, target)
end

entity.onMobDisengage = function(mob)
    xi.darkixion.onMobDisengage(mob)
end

entity.onMobFight = function(mob, target)
    xi.darkixion.onMobFight(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.darkixion.onMobDeath(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.darkixion.onMobDespawn(mob)
end

return entity
