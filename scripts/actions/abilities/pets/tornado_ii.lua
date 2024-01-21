-----------------------------------
-- Tornado II
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

-- Modeling this on the known formula for magical Merit BPs of the same level with a merit level of 0
abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local dINT   = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp     = pet:getTP() / 10

    if tp > 300 then
        tp = 300
    end

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    --note: this formula is only accurate for level 75 - 76+ may have a different intercept and/or slope
    local damage = math.floor(512 + 1.72 * (tp + 1))
    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage, xi.element.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.WIND)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.WIND, 1)

    pet:setTP(0) -- not possible to get Occult Acumen on avatars yet, so unable to determine if magical BPs can return TP.
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.WIND)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
