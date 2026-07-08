-----------------------------------
-- Ability: Dark Shot
-- Consumes a Dark Card to enhance dark-based debuffs. Additional effect: Dark-based Dispel
-- Bio Effect: Attack Down Effect +5% and DoT + 3
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.checkQuickDraw(player, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.corsair.useElementalShot(player, target, ability, action)
end

return abilityObject
