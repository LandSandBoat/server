-----------------------------------
-- Area: RuAun Gardens
--  Mob: Sprinkler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobMagicPrepare = function(mob, target, spellId)
    local cast = math.random()

    if cast >= 0.9 then
        return 212 -- Burst
    elseif cast >= 0.7 then
        return 167 -- Thunder IV
    elseif cast >= 0.5 then
        return 196 -- Thundaga III
    else
        return 166 -- Thunder III
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 142, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 143, 1, xi.regime.type.FIELDS)
end

return entity
