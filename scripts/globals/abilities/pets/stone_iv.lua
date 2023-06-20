-----------------------------------
-- Stone 4
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local dINT   = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp     = pet:getTP()
    local damage = math.floor(325 + 0.025 * tp)

    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.EARTH)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.EARTH)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
