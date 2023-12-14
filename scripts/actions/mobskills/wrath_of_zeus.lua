-----------------------------------
--  Wrath of Zeus
--
--  Description: Area of Effect lightning damage around Ixion (400-1000) and Silence.
--  Type: Magical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- to allow primary player to run out of range and to respect the real range of the mobskill
    if target:checkDistance(mob) > 15 then
        skill:setMsg(xi.msg.basic.NONE)
        return
    end

    local typeEffect = xi.effect.SILENCE
    local duration = math.random(30, 60)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, duration)

    local dmgmod = 4.5 -- unbuffed hit for ~700
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, xi.element.THUNDER, dmgmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    return dmg
end

return mobskillObject
