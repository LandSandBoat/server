-----------------------------------
-- Area: Promyvion-Vahzl
--  Mob: Apex Livid Rager
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') } -- TODO: confirm this
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.RAGER)
end

return entity
