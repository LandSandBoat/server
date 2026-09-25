-----------------------------------
-- Area: The Boyahda Tree
--   NM: Unut
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.UNUT - 2]  = ID.mob.UNUT,  -- Confirmed on retail
    [ID.mob.UNUT + 14] = ID.mob.UNUT,  -- Confirmed on retail
    [ID.mob.UNUT + 24]  = ID.mob.UNUT, -- Confirmed on retail
    [ID.mob.UNUT + 31]  = ID.mob.UNUT, -- Confirmed on retail

}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3600)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3600)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 359)
end

entity.onMobDespawn = function(mob)
end

return entity
