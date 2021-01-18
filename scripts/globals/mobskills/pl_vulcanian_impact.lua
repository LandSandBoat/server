---------------------------------------------------
-- Vulcanian Impact
--
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------
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
    local hpset=targetmaxHP*0.10
    local typeEffect = tpz.effect.BIND
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    if (targetcurrentHP > hpset) then
        dmg= targetcurrentHP - hpset
    else
        dmg=0
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end

return mobskill_object
