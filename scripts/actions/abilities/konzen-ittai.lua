-----------------------------------
-- Ability: Konzen-Ittai
-- Readies target for a skillchain.
-- Obtained: Samurai Level 65
-- Recast Time: 0:03:00
-- Duration: 1:00 or until next Weapon Skill
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.samurai.checkKonzenIttai(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.samurai.useKonzenIttai(player, target, ability, action)
end

return abilityObject
