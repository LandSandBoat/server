-----------------------------------
-- Ability: Ice Shot
-- Consumes an Ice Card to enhance ice-based debuffs. Deals ice-based magic damage
-- Frost Effect: Enhanced DoT and AGI-
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
