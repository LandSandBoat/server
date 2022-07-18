-----------------------------------
-- Area: South Gustaberg
--  Mob: Stone Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("[CastTime]ID_159", 10)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 77, 1, xi.regime.type.FIELDS)
end

return entity
