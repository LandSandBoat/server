-----------------------------------
-- Ability: Accomplice
-- Steals half of the target party member's enmity and redirects it to the thief.
-- Obtained: Thief Level 65
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/thief")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.thief.checkAccomplice(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.thief.useAccomplice(player, target, ability)
end

return ability_object
