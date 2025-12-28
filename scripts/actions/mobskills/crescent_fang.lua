-----------------------------------
-- Crescent Fang
-- Fenrir inflicts Paralysis along with a single attack to target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local ftp    = 5

    local damage = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 1, 2, 3)
    local totaldamage = xi.mobskills.mobFinalAdjustments(damage.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, numhits)

    target:takeDamage(totaldamage, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 50, 0, 90)

    return totaldamage
end

return mobskillObject
