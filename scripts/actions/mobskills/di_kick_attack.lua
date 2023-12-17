-----------------------------------
-- Unnamed attack for use to kick the target
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- don't autoattack between TP moves
    -- only initiate attack within 15 yalms, but db has higher range so you can't "outrun" an attack that starts
    if
        mob:getLocalVar('timeSinceWS') + 1 > os.time() or
        mob:checkDistance(target) > 15
    then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = .6

    local typeEffect = xi.effect.WEIGHT
    local duration = math.random(3, 15)
    local power = 50

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod)
    local dmg = 0
    if info.hitslanded > 0 then
        dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    else
        skill:setMsg(xi.msg.basic.EVADES)
        return
    end

    if skill:getMsg() ~= xi.msg.basic.SHADOW_ABSORB then
        if math.random(100) <= 75 then
            xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration)
        end

        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        skill:setMsg(xi.msg.basic.HIT_DMG)
    end

    return dmg
end

return mobskillObject
