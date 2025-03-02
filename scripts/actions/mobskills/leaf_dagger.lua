-----------------------------------
--  Leaf Dagger
--
--  Description: Deals piercing damage to a single target. Additional effect: Poison
--  Type: Physical
--  Utsusemi/Blink absorb: 2 shadows
--  Range: Melee?
--  Notes: On higher level Madragoras (Korrigans for example) the poision is 5hp/tick for about 5-6 ticks, damaging a total of 25-30 HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local ftp    = 1.4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)
    local power = math.max(1, mob:getMainLvl() / 10)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, power, 3, 18)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
