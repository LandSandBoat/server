-----------------------------------
-- Area: Promyvion-Dem
--  Mob: Apex Woeful Lamenter
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') } -- TODO: confirm this
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.LAMENTER)
end

return entity
