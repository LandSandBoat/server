-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Scylla
-----------------------------------
mixins = { require('scripts/mixins/families/ruszor') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 539)
end

return entity
