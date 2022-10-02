-----------------------------------
-- Ability: Benediction
-- Restores a large amount of HP and removes (almost) all status ailments for party members within area of effect.
-- Obtained: White Mage Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/white_mage")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.white_mage.checkBenediction(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.white_mage.useBenediction(player, target, ability)
end

return ability_object
