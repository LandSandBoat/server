-----------------------------------
--  Vitriolic Shower
--  Description: Expels a caustic stream at targets in a fan-shaped area of effect. Additional effect: Burn
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadow
--  Range: Cone
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 2.7)
    damage = damage + math.random(0, 7.5 + math.max(mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT) * 4 / 3, 0))

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 2, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, math.random(15, 35), 3, 60)

    return damage
end

return mobskillObject
