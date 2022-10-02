-----------------------------------
-- Ability: Martyr
-- Sacrifices HP to heal a party member double the amount.
-- Obtained: White Mage Level 75
-- Recast Time: 0:10:00
-- Duration: Instant
-- Target: Party member, cannot target self.
-----------------------------------
require("scripts/globals/job_utils/white_mage")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.white_mage.checkMartyr(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.white_mage.useMartyr(player, target, ability)
end

return ability_object
