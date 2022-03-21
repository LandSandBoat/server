-----------------------------------
--  MOB: Quick Draw Sasaroon
-- Area: Nyzul Isle
-- Info: Enemy Leader, Ranger
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end
