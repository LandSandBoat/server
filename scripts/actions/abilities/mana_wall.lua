-----------------------------------
-- Ability: Mana Wall
-- Description: Allows you to take damage with MP.
-- Obtained: BLM Level 76
-- Recast Time: 00:10:00
-- Duration: 00:05:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.black_mage.useManaWall(player, target, ability)
end

return abilityObject
