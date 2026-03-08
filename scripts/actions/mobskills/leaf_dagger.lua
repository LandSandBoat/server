-----------------------------------
--  Leaf Dagger
--
--  Description: Deals piercing damage to a single target. Additional effect: Poison
--  Type: Physical (Ranged)
--  Notes: On higher level Madragoras (Korrigans for example) the poision is 5hp/tick for about 5-6 ticks, damaging a total of 25-30 HP.
--  TODO: Should be subject to ranged penalties.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 1
    local accmod  = 1
    local ftp     = 2
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)
    local power   = math.max(1, mob:getMainLvl() / 10)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 90)

    return dmg
end

return mobskillObject
