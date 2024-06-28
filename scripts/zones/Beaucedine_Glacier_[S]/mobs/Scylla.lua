-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Scylla
-----------------------------------
mixins = { require('scripts/mixins/families/ruszor') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 539)
end

return entity
