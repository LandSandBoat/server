-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Executioner Antlion
-----------------------------------
mixins = { require('scripts/mixins/families/antlion_ambush_noaggro') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
