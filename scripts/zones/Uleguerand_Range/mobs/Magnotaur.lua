-----------------------------------
-- Area: Uleguerand Range
--   NM: Magnotaur
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.MAGNOTAUR - 2] = ID.mob.MAGNOTAUR,
    [ID.mob.MAGNOTAUR - 1] = ID.mob.MAGNOTAUR,
}

entity.spawnPoints =
{
    { x = -254.694, y = -185.189, z = 454.681 },
    { x = -250.987, y = -184.423, z = 446.010 },
}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 322)
end

return entity
