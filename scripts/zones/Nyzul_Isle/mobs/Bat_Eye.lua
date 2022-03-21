-----------------------------------
--  MOB: Bat Eye
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMobMod(xi.mobMod.CHECK_AS_NM)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end

return entity
