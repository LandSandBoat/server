-----------------------------------
--  MOB: Vile Ineef
-- Area: Nyzul Isle
-- Info: Enemy Leader
-----------------------------------
require('scripts/globals/nyzul')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- mob:addImmunity(xi.immunity.DARKSLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
