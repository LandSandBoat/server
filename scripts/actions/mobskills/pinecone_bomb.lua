-----------------------------------
-- Pinecone Bomb
-- Description: Deals damage in a 15' area around target. Additional effect: Sleep.
-- Type: Physical
-- Range: 15' AoE around target
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 1.5
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLEEP_I, 1, 0, 60)

    return dmg
end

return mobskillObject
