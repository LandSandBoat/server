-----------------------------------
-- Area: Promyvion-Vahzl
--  Mob: Stray (Weeper Model)
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.WEEPER)
end

return entity
