-----------------------------------
-- Area: Gustav Tunnel
--   NM: Taxim
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TAXIM - 11] = ID.mob.TAXIM, -- -172.941 -1.220 55.577
    [ID.mob.TAXIM - 4]  = ID.mob.TAXIM, -- -137.334 -0.108 48.105
    [ID.mob.TAXIM - 3]  = ID.mob.TAXIM, -- -118.000 -0.515 79.000
    [ID.mob.TAXIM + 2]  = ID.mob.TAXIM, -- -125.000 0.635 59.000
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3600)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3600)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 424)
end

return entity
