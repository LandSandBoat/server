-----------------------------------
-- Area: Mamook
--  Mob: Poroggo
-----------------------------------
mixins = { require('scripts/mixins/families/poroggo') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
