-----------------------------------
-- Ability: Warcry
-- Job: Warrior
-----------------------------------
require("scripts/globals/job_utils/warrior")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.warrior.checkWarcry(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.warrior.useWarcry(player, target, ability)
end

return ability_object
