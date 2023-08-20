-----------------------------------
--  Cross Reaver
--
--  Description: Deals high damage to players in a fan-shaped area. Additional effect: Stun
--  Type: Physical
--  ? ? ? (No data offered)
--  Range: Melee
-- Special weaponskill unique to Ark Angel HM. Deals ~500-900 damage.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Can skillchain?  Unknown property.

    local numhits = 2
    local accmod = 1
    local dmgmod = 4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
