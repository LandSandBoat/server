-----------------------------------
-- Ability: Cooldown
-- Description: Reduces the strain on your automaton.
-- Obtained: PUP Level 95
-- Recast Time: 00:05:00
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if not player:getPet() then
        -- TODO: Add check to verify this is an automaton
        return xi.msg.basic.REQUIRES_A_PET, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local jpValue = player:getJobPointLevel(xi.jp.COOLDOWN_EFFECT)

    player:reduceBurden(50, jpValue)

    if player:hasStatusEffect(xi.effect.OVERLOAD) then
        player:delStatusEffect(xi.effect.OVERLOAD)
    end
end

return abilityObject
