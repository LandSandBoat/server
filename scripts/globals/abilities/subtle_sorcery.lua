-----------------------------------
-- Ability: Subtle Sorcery
-- Description: Reduces the amount of enmity generated from magic spells and increases magic accuracy.
-- Obtained: BLM Level 96
-- Recast Time: 01:00:00
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/job_utils/black_mage")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.black_mage.checkSubtleSorcery(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.black_mage.useSubtleSorcery(player, target, ability)
end

return abilityObject
