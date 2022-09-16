-----------------------------------
-- Ability: Sepulcher
-- Description: Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for undead.
-- Obtained: PLD Level 87
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/job_utils/paladin")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.paladin.checkSepulcher(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.paladin.useSepulcher(player, target, ability)
end

return ability_object
