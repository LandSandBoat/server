-----------------------------------
-- Area: Caedarva Mire
--  Mob: Lamia Fatedealer
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
