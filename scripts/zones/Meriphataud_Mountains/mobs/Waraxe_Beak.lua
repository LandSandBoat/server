-----------------------------------
-- Area: Meriphataud Mountains (119)
--   NM: Waraxe Beak
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
