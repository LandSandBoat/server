-----------------------------------
--  MOB: Heraldic Imp
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.specifiedGroupKill(mob)
    end
end
