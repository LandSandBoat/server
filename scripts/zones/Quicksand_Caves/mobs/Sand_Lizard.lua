-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Lizard
-- Note: PH for Nussknacker
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 817, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    if mob:getWeather() == xi.weather.SAND_STORM then
        xi.mob.phOnDespawn(mob, ID.mob.NUSSKNACKER_PH, 15, 5400) -- 1 1/2 hour minimum
    end
end

return entity
