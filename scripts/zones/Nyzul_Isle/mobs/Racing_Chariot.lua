-----------------------------------
--  MOB: Racing Chariot
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------
mixins = { require('scripts/mixins/families/chariot') }
require('scripts/globals/nyzul')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedGroupKill(mob)
    end
end

return entity
