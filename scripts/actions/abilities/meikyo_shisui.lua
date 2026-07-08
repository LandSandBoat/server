-----------------------------------
-- Ability: Meikyo Shisui
-- Reduces cost of weapon skills.
-- Obtained: Samurai Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.samurai.checkMeikyoShisui(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.samurai.useMeikyoShisui(player, target, ability)
end

return abilityObject
