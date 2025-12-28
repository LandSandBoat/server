-----------------------------------
-- Sickle Slash
-- Deals critical damage. Chance of critical hit varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

-----------------------------------
-- onMobSkillCheck
-- Check for Ghrah family spider form.
-- If not in Spider form, then ignore.
-----------------------------------
mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getFamily() == 122 and
        mob:getAnimationSub() ~= 2
    then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
