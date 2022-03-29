-----------------------------------
--  MOB: Zizzy Zillah
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/nyzul")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:AnimationSub(13)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end

return entity
