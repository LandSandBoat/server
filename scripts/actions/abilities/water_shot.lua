-----------------------------------
-- Ability: Water Shot
-- Consumes a Water Card to enhance water-based debuffs. Deals water-based magic damage
-- Drown Effect: Enhanced DoT and STR-
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
