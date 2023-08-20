-----------------------------------
-- Stave Toss (staff wielding Mamool Ja only!)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- If animationSub is 1, mob has already lost the staff. If zero, still has staff.
    if
        mob:getAnimationSub() == 0 and
        (mob:getMainJob() == xi.job.BLM or mob:getMainJob() == xi.job.WHM)
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    mob:setAnimationSub(1) -- Mob loses Staff on using Stave Toss
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
