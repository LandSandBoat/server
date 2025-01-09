-----------------------------------
-- Area: Ranguemont Pass
--   NM: Tros
-- Used in Quests: Painful Memory
-- !pos -289 -45 212 166
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
