-----------------------------------
-- Ability: Soul Jump
-- Description: Delivers a high jumping attack on a targeted enemy which suppresses enmity. Effect enhanced when wyvern is present.
-- Obtained: DRG Level 85
-- Recast Time: 2:00
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.dragoon.useSoulJump(player, target, ability, action)
end

return abilityObject
