-----------------------------------
--  Morning Glory
--  Family: Euvhi
--  Description: Hits nearby targets with a petal bloom.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--
--  Only used in "closed" flower state
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- animation sub 0b010 = open
    if bit.band(mob:getAnimationSub(), 0x02) == 0x02 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
