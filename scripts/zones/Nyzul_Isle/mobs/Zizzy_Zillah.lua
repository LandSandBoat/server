-----------------------------------
--  MOB: Zizzy Zillah
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobSpawn(mob)
    mob:AnimationSub(13)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.eliminateAllKill(mob)
    end
end
