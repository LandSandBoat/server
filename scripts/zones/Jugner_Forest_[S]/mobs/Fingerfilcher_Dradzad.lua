-----------------------------------
-- Area: Jugner Forest [S]
--   NM: Fingerfilcher Dradzad
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
