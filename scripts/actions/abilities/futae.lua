-----------------------------------
-- Ability: Futae
-- Grants a bonus to your next elemental ninjutsu by expending two ninja tools.
-- Obtained: Ninja Level 77
-- Recast Time: 3:00
-- Duration: 1:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.ninja.checkFutae(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.ninja.useFutae(player, target, ability, action)
end

return abilityObject
