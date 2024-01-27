-----------------------------------
-- Ability: Sange
-- Daken will always activate but consumes shuriken while active.
-- Obtained: Ninja Level 75 Merits
-- Recast Time: 3 minutes
-- Duration: 1 minute
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local potency = player:getMerit(xi.merit.SANGE)-1

    player:addStatusEffect(xi.effect.SANGE, potency * 25, 0, 60)
end

return abilityObject
