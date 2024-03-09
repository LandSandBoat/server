-----------------------------------
--  Acheron Kick
--
--  Description: Physical Cone Attack damage behind user.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Back
--  Dark Ixion CAN turn around to use this move on anyone with hate, regardless of their original position or even distance.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- to allow primary player to run out of conal and to respect the real range of the mobskill
    if
        not target:isBehind(mob, 64) or
        target:checkDistance(mob) > 10
    then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return
    end

    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod)

    local dmg = 0
    if info.hitslanded > 0 then
        dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return
    end

    if skill:getMsg() ~= xi.msg.basic.SHADOW_ABSORB then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        skill:setMsg(xi.msg.basic.DAMAGE)
    end

    return dmg
end

return mobskillObject
