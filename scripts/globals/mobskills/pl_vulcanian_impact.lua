-----------------------------------
-- Vulcanian Impact
--
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if (mobSkin == 281) then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local targetcurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset = targetmaxHP * 0.10
    local typeEffect = xi.effect.BIND
    local dmg = 0
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    if targetcurrentHP > hpset then
        dmg = targetcurrentHP - hpset
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
