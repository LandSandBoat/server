-----------------------------------
-- Ability: Camouflage
-- Become hidden from enemies.
-- Obtained: Ranger Level 20
-- Recast Time: 5:00
-- Duration: Random
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local duration = math.random(30, 300) * (1 + 0.01 * player:getMod(xi.mod.CAMOUFLAGE_DURATION))
    player:addStatusEffect(xi.effect.CAMOUFLAGE, 1 , 0, math.floor(duration * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER))
end

return abilityObject
