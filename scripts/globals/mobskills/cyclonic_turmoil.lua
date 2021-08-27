-----------------------------------
-- Cyclonic Turmoil
--
-- Deals Wind damage in an area of effect. Additional effect: Knockback & Dispel
-- Notes: Dispels multiple buffs. Wipes shadows.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2.8, xi.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    local dispel1 = target:dispelStatusEffect()
    local dispel2 = target:dispelStatusEffect()
    local total = 0

    if (dispel1 ~= xi.effect.NONE) then
        total = total+1
    end

    if (dispel2 ~= xi.effect.NONE) then
        total = total+1
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    if (total == 0) then
        return dmg
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        return total
    end
end

return mobskill_object
