-----------------------------------
-- Ability: Scarlet Delirium
-- Description: Channels damage taken into enhanced attack and magic attack.
-- Obtained: DRK Level 95
-- Recast Time: 00:01:30
-- Duration: 00:01:30
-----------------------------------
require("scripts/globals/job_utils/dark_knight")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useScarletDelirium(player, target, ability)
end

return ability_object
