-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Shadowsoul Devourer
-----------------------------------
mixins = { require('scripts.mixins.families.red_dragon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
