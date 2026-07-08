-----------------------------------
-- Ability: Earth Shot
-- Consumes an Earth Card to enhance earth-based debuffs. Deals earth-based magic damage
-- Rasp Effect: Enhanced DoT and DEX-, Slow Effect +10%
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
