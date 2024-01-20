-----------------------------------
-- Holy Mist
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local dint = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = 600 + dint * 1.5 + pet:getTP() / 20

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    target:updateEnmityFromDamage(pet, dmg)
    target:takeDamage(dmg, pet, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end

return abilityObject
