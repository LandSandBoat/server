-----------------------------------
--  Lightning Spear
--
--  Description: Wide Cone Attack lightning damage (600-1500) and powerful Amnesia.
--  Type: Magical
--  Notes: Will pick a random person on the hate list for this attack.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- to allow primary player to run out of conal and to respect the real range of the mobskill
    if
        not target:isInfront(mob, 64) or
        target:checkDistance(mob) > 20
    then
        skill:setMsg(xi.msg.basic.NONE)
        return
    end

    local typeEffect = xi.effect.AMNESIA
    local duration = math.random(30, 120)

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, duration)

    local dmgmod = 10 -- unbuffed player hit for ~2k

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, xi.element.THUNDER, dmgmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)

    return dmg
end

return mobskillObject
