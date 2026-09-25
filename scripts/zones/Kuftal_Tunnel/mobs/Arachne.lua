-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Arachne
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ARACHNE - 5] = ID.mob.ARACHNE, -- Confirmed on retail
    [ID.mob.ARACHNE - 1] = ID.mob.ARACHNE, -- Confirmed on retail
    [ID.mob.ARACHNE + 3] = ID.mob.ARACHNE, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.STORETP, 125)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 420)
end

entity.onMobDespawn = function(mob)
end

return entity
