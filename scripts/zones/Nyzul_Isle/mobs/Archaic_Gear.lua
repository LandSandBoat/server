-----------------------------------
--  MOB: Archaic Gear
-- Area: Nyzul Isle
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    xi.nyzul.onGearEngage(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.nyzul.onGearDeath(mob, player, optParams)
end

return entity
