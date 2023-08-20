-----------------------------------
-- Ability: Elemental Seal
-- Enhances the accuracy of the user's next spell
-- Obtained: Black Mage Level 15
-- Recast Time: 10:00
-- Duration: 1 Spell or 60 seconds, whichever occurs first.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.black_mage.useElementalSeal(player, target, ability)
end

return abilityObject
