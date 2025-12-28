-----------------------------------
--  Lightning Spear
--
--  Description: Wide Cone Attack lightning damage (600-1500) and powerful Amnesia.
--  Type: Magical
--  Notes: Will pick a random person on the hate list for this attack.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- parameters for AE
    local typeEffect = xi.effect.AMNESIA
    local power      = 1
    local duration   = xi.mobskills.calculateDuration(30, 120)

    -- perform magical attack
    local damage = 2 * mob:getWeaponDmg()
    local dmgmod = 10 -- unbuffed player hit for ~2k

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    if damage > 0 then
        target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)

        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration)
    end

    return damage
end

return mobskillObject
