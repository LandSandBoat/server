-----------------------------------
-- Ability: Warrior's Charge
-- Job: Warrior
-----------------------------------
require("scripts/globals/job_utils/warrior")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.warrior.useWarriorsCharge(player, target, ability)
end

return ability_object
