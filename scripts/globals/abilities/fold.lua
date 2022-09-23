-----------------------------------
-- Ability: Fold
-- Erases one roll or bust xi.effect. Targets self-cast effect with the longest remaining duration.
-- Obtained: Corsair Level 75
-- Recast Time: 00:05:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (target:hasCorsairEffect()) then
        return 0, 0
    else
        return xi.msg.basic.CANNOT_PERFORM, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    target:fold()

    local merit = target:getMerit(xi.merit.FOLD)
    merit = merit - 10

    if (math.random(0, 99) < merit) then
        target:resetRecast(xi.recast.ABILITY, 193)
    end

    -- return xi.effect.FOLD -- TODO: implement xi.effect.FOLD
end

return ability_object
