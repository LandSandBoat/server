-----------------------------------
-- Area: The Sanctuary of ZiTah
--   NM: Keeper of Halidom
-----------------------------------
local ID = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.KEEPER_OF_HALIDOM - 1] = ID.mob.KEEPER_OF_HALIDOM, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 324)
    xi.magian.onMobDeath(mob, player, optParams, set{ 73, 287, 435 })
end

entity.onMobDespawn = function(mob)
end

return entity
