-----------------------------------
-- Ability: Palisade
-- Description: Increases chance of blocking with shield, and eliminates enmity loss.
-- Obtained: PLD Level 95
-- Recast Time: 00:05:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/job_utils/paladin")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.paladin.usePalisade(player, target, ability)
end

return abilityObject
