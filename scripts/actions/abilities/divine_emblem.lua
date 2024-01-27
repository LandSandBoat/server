-----------------------------------
-- Ability: Divine Emblem
-- Description: Enhances the accuracy of your next divine magic spell and increases enmity.
-- Obtained: PLD Level 78
-- Recast Time: 00:03:00
-- Duration: 00:01:00 or the next spell cast
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.paladin.useDivineEmblem(player, target, ability)
end

return abilityObject
