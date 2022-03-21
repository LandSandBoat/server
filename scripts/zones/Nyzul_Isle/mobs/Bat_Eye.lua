-----------------------------------
--  MOB: Bat Eye
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobSpawn(mob)
    mob:addMobMod(xi.mobMod.CHECK_AS_NM)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.eliminateAllKill(mob)
    end
end
