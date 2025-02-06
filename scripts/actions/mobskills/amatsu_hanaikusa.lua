-----------------------------------
--  Amatsu: Hanaikusa
--  Type: Physical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getObjType() == xi.objType.TRUST or
        mob:getAnimationSub() == 0
    then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 22.5
    local duration = 60
    local numhits  = 1
    local accmod   = 2
    local ftp      = 6
    local info     = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5625, 1.875, 2.50)
    local dmg      = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    if info.hitslanded > 0 then
        target:addStatusEffect(xi.effect.PARALYSIS, power, 0, duration)
    end

    return dmg
end

return mobskillObject
