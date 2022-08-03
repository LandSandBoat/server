-----------------------------------
-- Ability: Devotion
-- Sacrifices HP to grant a party member the same amount in MP.
-- Obtained: White Mage Level 75
-- Recast Time: 0:10:00
-- Duration: Instant
-- Target: Party member, cannot target self.
-----------------------------------
require("scripts/globals/job_utils/white_mage")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.white_mage.checkDevotion(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.white_mage.useDevotion(player, target, ability)
end

return ability_object
