-----------------------------------
-- Area: Promyvion-Vahzl
--  Mob: Stray (Seether Model)
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.SEETHER)
end

return entity
