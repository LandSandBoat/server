-----------------------------------
-- Acheron Flame
-- Description: Deals severe Fire damage to enemies within an area of effect. Additional effect: Burn
-- Type:  Magical
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 20' radial
-- Notes: Only used when a cerberus's health is 25% or lower (may not be the case for Orthrus). The burn effect takes off upwards of 20 HP per tick.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 1793 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local element = mob:getStatusEffectElement(xi.effect.BURN)
    local resist = xi.mobskills.applyPlayerResistance(mob, xi.effect.BURN, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, element)

    local power = ((resist * 10) - 5) * math.random(1, 2) + 19 -- makes dot damage between 20 - 28, based off resistance and random variable.
    local dmgmod = 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 6, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, 60)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return dmg
end

return mobskillObject
