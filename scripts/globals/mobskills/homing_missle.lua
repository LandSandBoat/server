-----------------------------------
-- Homing Missle
--
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local targetcurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset = targetmaxHP * 0.20
    local typeEffect = xi.effect.BIND
    local dmg = 0

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    if (targetcurrentHP > hpset) then
        dmg = targetcurrentHP - hpset
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return dmg
end

return mobskill_object
