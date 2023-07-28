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
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.onGearDeath(mob)
    end
end

return entity
