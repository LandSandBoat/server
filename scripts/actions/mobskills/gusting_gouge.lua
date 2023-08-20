-----------------------------------
--  Gusting Gouge
--  Description: Deals Wind damage in a threefold attack to targets in a fan-shaped area of effect.
--  Type: Physical?
--  Utsusemi/Blink absorb: 2-3 shadows
--  Notes: Used only by Lamia equipped with a one-handed weapon. If they lost their weapon, they'll use Hysteric Barrage instead.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() == 0 and
        (
            mob:getMainJob() == xi.job.COR or
            mob:getMainJob() == xi.job.BRD or
            mob:getMainJob() == xi.job.RDM
        )
    then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCE, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
