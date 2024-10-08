-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Greater Amphiptere
-----------------------------------
mixins = { require('scripts/mixins/families/amphiptere') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
