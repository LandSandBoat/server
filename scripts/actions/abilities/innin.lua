-----------------------------------
-- Ability: Innin
-- Reduces enmity and impairs evasion. Grants a bonus to accuracy, critical hit rate, and ninjutsu damage when striking target from behind.
-- Obtained: Ninja Level 40
-- Recast Time: 3:00
-- Duration: 5:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.ninja.checkInnin(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.ninja.useInnin(player, target, ability, action)
end

return abilityObject
