-----------------------------------
-- Gastric Bomb
-- Deals Water damage with a long-range acid bomb. Additional effect: Attack Down
-- Range: Long range
-- Notes: Attack Down effect is 50%.
-- Duration: Three minutes
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 180
    local power = 50

    if skill:getID() == 1886 then -- Nightmare Worm - 90%
        power = 90
    end

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 2, 2.5, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, power, 0, duration)

    return dmg
end

return mobskillObject
