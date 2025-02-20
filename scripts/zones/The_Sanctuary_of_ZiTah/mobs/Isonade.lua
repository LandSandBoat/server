-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Isonade
-- Involved in Quest: The Sacred Katana
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
