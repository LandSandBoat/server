-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Pit Antlion
-----------------------------------
mixins = { require('scripts/mixins/families/antlion_ambush') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
