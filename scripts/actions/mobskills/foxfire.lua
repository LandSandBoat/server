-----------------------------------
--  Foxfire
--
--  Description: Damage varies with TP. Additional effect: "Stun."
--  Type: Physical (Blunt)
-- RDM, THF, PLD, BST, BRD, RNG, NIN, and COR fomors).
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local job = mob:getMainJob()

    -- TODO: Table this
    if
        job == xi.job.RDM or
        job == xi.job.THF or
        job == xi.job.PLD or
        job == xi.job.BST or
        job == xi.job.RNG or
        job == xi.job.BRD or
        job == xi.job.NIN or
        job == xi.job.COR
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.6
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.STUN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 6)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
