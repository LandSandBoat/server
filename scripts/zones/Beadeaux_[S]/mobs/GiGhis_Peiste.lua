-----------------------------------
-- Area: Beadeaux_[S]
--  Mob: GiGhi's Peiste
-----------------------------------
mixins = { require('scripts/mixins/families/peiste') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
