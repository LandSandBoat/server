-----------------------------------
-- Area: Fei'Yin
--   NM: Western Shadow
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.WESTERN_SHADOW - 2] = ID.mob.WESTERN_SHADOW, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMod(xi.mod.COUNTER, 0)
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDespawn = function(mob)
end

return entity
