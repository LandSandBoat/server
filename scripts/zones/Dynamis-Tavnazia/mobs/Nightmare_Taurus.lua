-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Taurus
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

return entity
