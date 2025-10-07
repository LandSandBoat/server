-----------------------------------
--  Hoof Volley
--  Family: Hippogryph
--  Description: Deals critical damage to a single target. Resets hate and causes knockback.
--  Type: Physical
--  Utsusemi/Blink absorb: One shadow
--  Range: Melee
--  Notes: Easily stunnable
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 4
    local params = { canCrit = true }
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0, params)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if mob:getObjType() == xi.objType.MOB then
        mob:resetEnmity(target)
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
