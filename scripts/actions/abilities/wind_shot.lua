-----------------------------------
-- Ability: Wind Shot
-- Consumes a Wind Card to enhance wind-based debuffs. Deals wind-based magic damage
-- Choke Effect: Enhanced DoT and VIT-
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
