-----------------------------------
-- Moonlit Charge
-- Fenrir inflicts Blindness along with a single attack (knockback) to target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local ftp    = 4

    local damage = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, 0, xi.mobskills.physicalTpBonus.NO_EFFECT, 1, 2, 3)
    local totaldamage = xi.mobskills.mobFinalAdjustments(damage.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, numhits)
    target:addStatusEffect(xi.effect.BLINDNESS, 20, 0, 30)
    target:takeDamage(totaldamage, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return totaldamage
end

return mobskillObject
