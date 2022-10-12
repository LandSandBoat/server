-----------------------------------
-- Ability: Tomahawk
-- Job: Warrior
-----------------------------------
require("scripts/globals/job_utils/warrior")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.warrior.checkTomahawk(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.warrior.useTomahawk(player, target, ability)
end

return abilityObject
