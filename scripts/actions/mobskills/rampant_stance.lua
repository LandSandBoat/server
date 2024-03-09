-----------------------------------
-- Rampant Stance
-- Physical area of effect damage that inflicts stun.
-- Utsusemi/Blink absorb: 1-4 shadows, wipes Third Eye
-- Range: 7.0 (add 0.1-4 depending on terrain elevation)
-- Notes: Takes roughly three seconds to charge the TP move up, enough time for anyone within range to easily back out and run back in directly after the animation begins.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- to allow primary player to run out of range and to respect the real range of the mobskill
    if target:checkDistance(mob) > 8 then
        skill:setMsg(xi.msg.basic.NONE)
        return
    end

    local numhits = 3
    local accmod = 2
    local dmgmod = 1

    local typeEffect = xi.effect.STUN
    local duration = math.random(1, 3)

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod)
    local dmg = 0
    if info.hitslanded > 0 then
        dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    else
        skill:setMsg(xi.msg.basic.EVADES)
        return
    end

    if skill:getMsg() ~= xi.msg.basic.SHADOW_ABSORB then
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, duration)

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        skill:setMsg(xi.msg.basic.HIT_DMG)
    end

    return dmg
end

return mobskillObject
