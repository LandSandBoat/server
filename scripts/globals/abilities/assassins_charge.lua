-----------------------------------
-- Ability: Assassin's Charge
-- Will triple your next attack.
-- Obtained: Thief Level 75
-- Recast Time: 5:00
-- Duration: 1:00 minute
-----------------------------------
require("scripts/globals/job_utils/thief")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.thief.useAssassinsCharge(player, target, ability)
end

return ability_object
