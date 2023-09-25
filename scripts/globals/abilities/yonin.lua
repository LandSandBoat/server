-----------------------------------
-- Ability: Yonin
-- Increases enmity and enhances "Ninja Tool Expertise" effect, but impairs accuracy. Improves evasion and reduces enemy Critical Hit Rate when in front of target.
-- Obtained: Ninja Level 40
-- Recast Time: 3:00
-- Duration: 5:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:delStatusEffect(xi.effect.INNIN)
    target:delStatusEffect(xi.effect.YONIN)
    target:addStatusEffect(xi.effect.YONIN, 30, 15, 300, 0, 20)
end

return abilityObject
