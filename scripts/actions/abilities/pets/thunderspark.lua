-----------------------------------
-- Thunderspark
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local damage = math.floor(275 + pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage, xi.element.THUNDER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage, xi.element.THUNDER, petskill)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    target:updateEnmityFromDamage(pet, damage)

    target:addStatusEffect(xi.effect.PARALYSIS, 15, 0, 60)

    return damage
end

return abilityObject
