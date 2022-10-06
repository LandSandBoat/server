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
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.white_mage.checkDevotion(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.white_mage.useDevotion(player, target, ability)
end

return abilityObject
