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
    [ID.mob.WESTERN_SHADOW - 1] = ID.mob.WESTERN_SHADOW, -- -159.000 -16.000 146.000
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
