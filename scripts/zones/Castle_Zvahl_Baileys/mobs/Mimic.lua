-----------------------------------
-- Area: Castle Zvahl Baileys
--   NM: Mimic
-----------------------------------
mixins = { require('scripts/mixins/families/mimic') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

return entity
