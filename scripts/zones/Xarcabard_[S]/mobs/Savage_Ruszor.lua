-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Savage Ruszor
-----------------------------------
mixins = { require('scripts/mixins/families/ruszor') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
