-----------------------------------
-- Geocrush
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local dINT   = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp     = pet:getTP() / 10
    local master = pet:getMaster()
    local merits = 0

    if master ~= nil and master:isPC() then
        merits = master:getMerit(xi.merit.GEOCRUSH)
    end

    tp = tp + (merits - 40)
    if tp > 300 then
        tp = 300
    end

    --note: this formula is only accurate for level 75 - 76+ may have a different intercept and/or slope
    local damage = math.floor(512 + 1.72 * (tp + 1))
    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.element.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.EARTH)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.EARTH)
    target:updateEnmityFromDamage(pet, damage)

    if not target:hasStatusEffect(xi.effect.STUN) then
        target:addStatusEffect(xi.effect.STUN, 3, 3, 3)
    end

    return damage
end

return abilityObject
