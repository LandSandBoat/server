-----------------------------------
--  MOB: Quick Draw Sasaroon
-- Area: Nyzul Isle
-- Info: Enemy Leader, Ranger
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.enemyLeaderKill(mob)
    end
end
