-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Huwasi
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -186.000, y = 0.000, z = -333.000 },
    { x = -12.000,  y = 0.000, z = -422.000 },
    { x = 292.000,  y = 0.000, z =   50.000 },
    { x = 334.000,  y = 1.000, z =  226.000 },
    { x = 5.000,    y = 0.000, z =  -22.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMod(xi.mod.STORETP, 130)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 326)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
end

return entity
