-----------------------------------
-- Area: Fei'Yin
--   NM: Eastern Shadow
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.EASTERN_SHADOW - 1] = ID.mob.EASTERN_SHADOW, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
end

entity.onMobDespawn = function(mob)
end

return entity
