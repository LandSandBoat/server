-----------------------------------
-- Floodlight
--
-- Description:  ~300 magic damage, Flash, Blind and Silence, ignores Utsusemi
-- Type: Magical
--
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local currentForm = mob:getLocalVar("form") -- Proto-Omega's script sets this.

    if (mob:getAnimationSub() == 2 and currentForm == 1) then -- omega first bipedform
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.LIGHT, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)

    MobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 3, 120)
    MobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end

return mobskill_object
