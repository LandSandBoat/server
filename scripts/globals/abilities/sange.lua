-----------------------------------
-- Ability: Sange
-- Daken will always activate but consumes shuriken while active.
-- Obtained: Ninja Level 75 Merits
-- Recast Time: 3 minutes
-- Duration: 1 minute
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local potency = player:getMerit(tpz.merit.SANGE)-1

    player:addStatusEffect(tpz.effect.SANGE, potency * 25, 0, 60)
end
