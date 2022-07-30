-----------------------------------
-- Aero 2
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp = skill:getTP()
    local dmgmod = 0

    if tp < 1500 then
        dmgmod = math.floor((29/256) * (tp/100) + (928/256))
    else
        dmgmod = math.floor(((29/256) * (1500/100)) + ((14/256) * ((tp-1500)/100)) + (928/256))
    end

    local damage = pet:getMainLvl() + 2 + (0.30 * pet:getStat(xi.mod.INT)) + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.WATER)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.WATER)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return ability_object
