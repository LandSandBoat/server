-----------------------------------
--  MOB: Archaic Gears
-- Area: Nyzul Isle
-----------------------------------
mixins = { require('scripts/mixins/families/gears') }
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    xi.nyzul.onGearEngage(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.nyzul.onGearDeath(mob, player, optParams)
end

return entity
