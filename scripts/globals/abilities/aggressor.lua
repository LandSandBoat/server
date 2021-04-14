-----------------------------------
-- Ability: Aggressor
-- Job: Warrior
-----------------------------------
require("scripts/globals/job_utils/warrior")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.warrior.checkAggressor(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.warrior.useAggressor(player, target, ability)
end

return ability_object
