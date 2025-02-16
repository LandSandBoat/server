-----------------------------------
--  Havoc Spiral
--  Description: Deals damage to players in an area of effect. Additional effect: Sleep
--  Type: Physical
--  2-3 Shadows
--  Range: Unknown
-- Special weaponskill unique to Ark Angel MR. Deals ~100-300 damage.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Can skillchain?  Unknown property.

    local numhits = 1
    local accmod = 1
    local ftp    = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    -- Witnessed 280 to a melee, 400 to a BRD, and 500 to a wyvern
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, math.random(30, 60))
    return dmg
end

return mobskillObject
