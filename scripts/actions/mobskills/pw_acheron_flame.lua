-----------------------------------
-- Acheron Flame
-- Description: Deals severe Fire damage to enemies within an area of effect. Additional effect: Burn
-- Type:  Magical
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 20' radial
-- Notes: Only used when a cerberus's health is 25% or lower (may not be the case for Orthrus). The burn effect takes off upwards of 20 HP per tick.
-----------------------------------
---@type TMobSkill
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
    local damage = mob:getWeaponDmg() * 6
    local resist = xi.mobskills.applyPlayerResistance(mob, xi.effect.BURN, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, xi.element.FIRE)
    local power  = (resist * 10 - 5) * math.random(1, 2) + 19 -- TODO: wtf is even this? If you are gonna make-up shit, at least limit it to a single math.random

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 3, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, 60)

    return damage
end

return mobskillObject
