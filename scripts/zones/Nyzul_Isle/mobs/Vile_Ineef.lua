-----------------------------------
--  MOB: Vile Ineef
-- Area: Nyzul Isle
-- Info: Enemy Leader
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARKSLEEP)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end
