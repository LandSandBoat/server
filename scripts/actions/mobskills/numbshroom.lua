-----------------------------------
-- Queasyshroom
-- Additional effect: Fires a mushroom cap, dealing damage to a single target. Additional effect: paralysis.
-- Range is 14.7 yalms.
-- Piercing damage Ranged Attack.
-- Secondary modifiers: INT: 20%.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getMobMod(xi.mobMod.VAR) == 1 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setMobMod(xi.mobMod.VAR, 2)
    local numhits = 1
    local accmod = 1
    local ftp    = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 35, 0, 180)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
