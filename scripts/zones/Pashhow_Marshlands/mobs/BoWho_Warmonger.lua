-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Bo'Who Warmonger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 60, 1, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(75600 + math.random(600, 900)) -- 21 hours, plus 10 to 15 min
end

return entity
