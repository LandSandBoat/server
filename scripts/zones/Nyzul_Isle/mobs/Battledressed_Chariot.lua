-----------------------------------
--  MOB: Battledressed Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Discoid
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.enemyLeaderKill(mob)
    end
end
