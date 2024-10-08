-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Amphiptere
-----------------------------------
mixins = { require('scripts/mixins/families/amphiptere') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
