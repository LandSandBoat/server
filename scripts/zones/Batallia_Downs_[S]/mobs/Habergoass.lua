-----------------------------------
-- Area: Batallia Downs [S]
--   NM: Habergoass
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  137.000, y =  8.500, z = -472.000 }
}

entity.phList =
{
    [ID.mob.HABERGOASS - 1] = ID.mob.HABERGOASS,
}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 75)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 493)
end

return entity
