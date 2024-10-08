-----------------------------------
-- Ability: Yonin
-- Increases enmity and enhances "Ninja Tool Expertise" effect, but impairs accuracy. Improves evasion and reduces enemy Critical Hit Rate when in front of target.
-- Obtained: Ninja Level 40
-- Recast Time: 3:00
-- Duration: 5:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.ninja.checkYonin(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.ninja.useYonin(player, target, ability, action)
end

return abilityObject
