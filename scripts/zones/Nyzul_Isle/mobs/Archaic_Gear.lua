-----------------------------------
--  MOB: Archaic Gear
-- Area: Nyzul Isle
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    xi.nyzul.onGearEngage(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.onGearDeath(mob)
    end
end

return entity
