-----------------------------------
--  Wrath of Zeus
--
--  Description: Area of Effect lightning damage around Ixion (400-1000) and Silence.
--  Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- parameters for AE
    local typeEffect = xi.effect.SILENCE
    local power      = 1
    local duration   = xi.mobskills.calculateDuration(30, 60)

    -- perform magical attack
    local damage = mob:getWeaponDmg()
    local dmgmod = 4.5 -- unbuffed hit for ~700

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    if damage > 0 then
        target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)

        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration)
    end

    return damage
end

return mobskillObject
