-----------------------------------
--  MOB: Vile Ineef
-- Area: Nyzul Isle
-- Info: Enemy Leader
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobInitialize(mob)
    mob:addImmunity(xi.immunity.DARKSLEEP)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.enemyLeaderKill(mob)
    end
end
