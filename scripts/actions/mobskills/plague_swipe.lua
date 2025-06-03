-----------------------------------
--  Plague Swipe
--
--  Description: Delivers a threefold attack in an cone effect behind user. Additional effect: Bio + Plague
--  Type: Physical
--  2-3 Shadows
--  Range: Backward Arc
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Replace this when there's a better method than isFacingTheSameDirection() aka isBehind
    if not target:isBehind(mob) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIO, 7, 3, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PLAGUE, 5, 3, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
