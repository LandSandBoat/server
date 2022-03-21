-----------------------------------
--  MOB: Zizzy Zillah
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobSpawn = function(mob)
    mob:AnimationSub(13)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end