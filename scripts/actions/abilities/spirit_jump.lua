-----------------------------------
-- Ability: Spirit Jump
-- Description: Delivers a short jumping attack on a targeted enemy which suppresses enmity. Effect enhanced when wyvern is present.
-- Obtained: DRG Level 77
-- Recast Time: 1:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.dragoon.useSpiritJump(player, target, ability, action)
end

return abilityObject
