-----------------------------------
-- Ability: Arcane Crest
-- Description: Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for arcana.
-- Obtained: DRK Level 87
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/job_utils/dark_knight")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dark_knight.checkArcaneCrest(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useArcaneCrest(player, target, ability)
end

return ability_object
