-----------------------------------
--  MOB: Heraldic Imp
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedGroupKill(mob)
    end
end
