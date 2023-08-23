-----------------------------------
-- Ability: Fold
-- Erases one roll or bust xi.effect. Targets self-cast effect with the longest remaining duration.
-- Obtained: Corsair Level 75
-- Recast Time: 00:05:00
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if target:hasCorsairEffect() then
        return 0, 0
    end

    return xi.msg.basic.CANNOT_PERFORM, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:fold()

    local merit = target:getMerit(xi.merit.FOLD) -10

    if math.random(0, 99) < merit then
        target:resetRecast(xi.recast.ABILITY, 193)
    end

    -- return xi.effect.FOLD -- TODO: implement xi.effect.FOLD
end

return abilityObject
