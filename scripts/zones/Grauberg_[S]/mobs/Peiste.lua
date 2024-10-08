-----------------------------------
-- Area: Grauberg_[S]
--  Mob: Peiste
-----------------------------------
mixins = { require('scripts/mixins/families/peiste') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
