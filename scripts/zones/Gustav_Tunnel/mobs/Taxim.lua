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
    [ID.mob.TAXIM - 4] = ID.mob.TAXIM, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3600)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3600)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 424)
end

return entity
