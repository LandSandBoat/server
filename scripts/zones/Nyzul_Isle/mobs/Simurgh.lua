-----------------------------------
--  MOB: Simurgh
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end
