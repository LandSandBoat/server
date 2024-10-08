-----------------------------------
-- Area: Arrapago Reef
--  Mob: Giant Orobon
-----------------------------------
mixins = { require('scripts/mixins/families/orobon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
