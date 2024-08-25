-----------------------------------
-- Ability: Unbridled Wisdom
-- Description: Allows certain blue magic spells to be cast.
-- Obtained: BLU Level 96
-- Recast Time: 01:00:00
-- Duration: 00:01:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.blue_mage.checkUnbridledWisdom(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.blue_mage.useUnbridledWisdom(player, target, ability, action)
end

return abilityObject
