-----------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Duke Decapod
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -281.000, y = -26.101, z = 659.000 },
    { x = -267.000, y = -22.101, z = 664.000 },
    { x = -229.000, y = -22.101, z = 654.000 },
    { x = -216.000, y = -22.101, z = 624.000 },
    { x = -236.000, y = -24.101, z = 607.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setRespawnTime(math.random(3600, 4200)) -- When server restarts, reset timer
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobFight = function(mob, target)
    local castTime = mob:getLocalVar('dukeWater')

    if GetSystemTime() > castTime then
        mob:castSpell(169, target)
        mob:setLocalVar('dukeWater', GetSystemTime() + 10)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 255)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200))
end

return entity
