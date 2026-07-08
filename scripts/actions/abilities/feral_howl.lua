-----------------------------------
-- Ability: Feral Howl
-- Terrorizes the target.
-- Obtained: Beastmaster Level 75
-- Recast Time: 0:05:00
-- Duration: Apprx. 0:00:01 - 0:00:10
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.checkFeralHowl(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.beastmaster.useFeralHowl(player, target, ability, action)
end

return abilityObject
