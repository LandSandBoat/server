-----------------------------------
-- Meteorite
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local dint = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = 500 + dint * 1.5 + pet:getTP() / 20
    target:updateEnmityFromDamage(pet, dmg)
    target:takeDamage(dmg, pet, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end

return abilityObject
