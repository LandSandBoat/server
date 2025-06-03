-----------------------------------
-- Queasyshroom
-- Additional effect: Poison. Duration of effect varies with TP.
-- Range is 13.5 yalms.
-- Piercing damage Ranged Attack.
-- Secondary modifiers: INT: 20%.
-- Additional Effect: Poison is based on level
-- Poison effect may resist
-- Removes all Shadow Images on the target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getMobMod(xi.mobMod.VAR) == 0 then
        return 0
    end

    return 1
end

-- TODO: can crit
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setMobMod(xi.mobMod.VAR, 1)
    local numhits = 1
    local accmod = 1
    local ftp    = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    local power = mob:getMainLvl() / 10 + 1

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
