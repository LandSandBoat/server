-----------------------------------
-- Ability: Enmity Douse
-- Description: Reduces the target's enmity towards you.
-- Obtained: BLM Level 87
-- Recast Time: 0:10:00
-----------------------------------
require("scripts/globals/job_utils/black_mage")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.black_mage.useEnmityDouse(player, target, ability)
end

return ability_object
