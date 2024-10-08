-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Troll Sabreur
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
