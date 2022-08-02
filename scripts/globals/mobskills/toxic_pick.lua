-----------------------------------
-- Toxic Pick
-- Deals damage to a single target. Additional effect: Poison, Plague, Gravity effect on target
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.2
    local power = math.ceil(mob:getMainLvl() / 5)
    local poisonPower

    if mob:getPool() == 1532 then
        poisonPower = 30
    else
        poisonPower = math.ceil(mob:getMainLvl() / 5)
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, poisonPower, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, power, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 1, 0, 60)

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
