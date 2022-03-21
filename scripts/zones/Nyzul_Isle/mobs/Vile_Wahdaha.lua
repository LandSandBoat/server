-----------------------------------
--  MOB: Vile Wahdaha
-- Area: Nyzul Isle
-- Info: Enemy Leader
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end
