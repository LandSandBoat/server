-----------------------------------
-- Ability: Intervene
-- Description: Strikes the target with your shield and decreases its attack and accuracy.
-- Obtained: PLD Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/job_utils/paladin")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.paladin.checkIntervene(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.paladin.useIntervene(player, target, ability)
end

return ability_object
