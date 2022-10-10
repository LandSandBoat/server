-----------------------------------
-- Ability: Feint
-- Reduces targets evasion by -150 (Assassin's Culottes +2 Aug: -10 more eva per merit)
-- Obtained: Thief Level 75
-- Recast Time: 2:00 minutes
-- Duration: 1:00 minutes
-----------------------------------
require("scripts/globals/job_utils/thief")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.thief.useFeint(player, target, ability)
end

return abilityObject
