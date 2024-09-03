-----------------------------------
-- Area: Arrapago Reef
--  Mob: Heraldic Imp
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
