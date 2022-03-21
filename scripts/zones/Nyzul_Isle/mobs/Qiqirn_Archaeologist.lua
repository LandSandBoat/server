-----------------------------------
--  MOB: Qiqirn Archaeologist
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedGroupKill(mob)
    end
end
