-----------------------------------
-- Meteorite
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local dint = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local damage = 500 + dint*1.5 + skill:getTP()/20

    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.LIGHT)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:updateEnmityFromDamage(pet, damage)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return damage
end

return ability_object
