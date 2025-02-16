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

    local damage = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, 0, xi.mobskills.physicalTpBonus.NO_EFFECT, 1, 2, 3)
    local totaldamage = xi.mobskills.mobFinalAdjustments(damage.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, numhits)

    if damage.hitslanded > 0 then
        target:addStatusEffect(xi.effect.PARALYSIS, 50, 0, 90)
    end

    target:takeDamage(totaldamage, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return totaldamage
end

return mobskillObject
