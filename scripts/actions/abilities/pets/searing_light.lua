-----------------------------------
-- Searing Light
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local damage = math.floor(26 + pet:getMainLvl() * 6 + (pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)) * 1.5)

    damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage, xi.element.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage, xi.element.LIGHT, petskill)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    target:updateEnmityFromDamage(pet, damage)
    summoner:setMP(0)

    return damage
end

return abilityObject
