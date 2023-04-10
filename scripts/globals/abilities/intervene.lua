-----------------------------------
-- Ability: Intervene
-- Description: Strikes the target with your shield and decreases its attack and accuracy.
-- Obtained: PLD Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/job_utils/paladin")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.paladin.checkIntervene(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.paladin.useIntervene(player, target, ability)
end

return abilityObject
