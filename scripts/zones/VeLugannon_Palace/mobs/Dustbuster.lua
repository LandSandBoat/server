-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Dustbuster
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
    xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 745, 1, xi.regime.type.GROUNDS)
end

return entity
