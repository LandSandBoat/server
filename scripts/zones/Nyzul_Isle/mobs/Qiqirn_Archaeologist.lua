-----------------------------------
--  MOB: Qiqirn Archaeologist
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.specifiedGroupKill(mob)
    end
end
