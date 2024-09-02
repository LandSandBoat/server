-----------------------------------
-- Area: Bhaflau Remnants
--  Mob: Colibri
-----------------------------------
mixins = { require('scripts/mixins/families/colibri_mimic') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
