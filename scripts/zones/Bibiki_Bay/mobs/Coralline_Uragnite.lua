-----------------------------------
-- Area: Bibiki Bay
--  Mob: Coralline Uragnite
-----------------------------------
mixins = { require('scripts/mixins/families/uragnite') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
