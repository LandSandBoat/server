-----------------------------------
--  Rushing Drub
--
--  Description: Delivers a fourfold attack on a single target.
--  Type: Physical
--  Utsusemi/Blink absorb: 4 shadows
--  Range: Melee
--  Notes: Only used by Mamool Ja with staves.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() == 0 and
        (mob:getMainJob() == xi.job.BLM or mob:getMainJob() == xi.job.WHM)
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local ftp    = 0.75
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
