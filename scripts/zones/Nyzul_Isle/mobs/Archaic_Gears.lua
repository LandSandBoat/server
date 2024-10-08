-----------------------------------
--  MOB: Archaic Gears
-- Area: Nyzul Isle
-----------------------------------
mixins = { require('scripts/mixins/families/gears') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    xi.nyzul.onGearEngage(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.nyzul.onGearDeath(mob, player, optParams)
end

return entity
