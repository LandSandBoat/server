-----------------------------------
-- Cyclonic Turmoil
--
-- Deals Wind damage in an area of effect. Additional effect: Knockback & Dispel
-- Notes: Dispels multiple buffs. Wipes shadows.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.8, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    local dispel1 = target:dispelStatusEffect()
    local dispel2 = target:dispelStatusEffect()
    local total = 0

    if dispel1 ~= xi.effect.NONE then
        total = total + 1
    end

    if dispel2 ~= xi.effect.NONE then
        total = total + 1
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    if total == 0 then
        return dmg
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        return total
    end
end

return mobskillObject
