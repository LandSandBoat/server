-----------------------------------
--  Gravity Wheel
--
--  Description: Deals heavy damage to players in an area of effect. Additional effect: Weight
--  Type: Physical
--  2-3 Shadows
--  Range: Unknown
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:getAnimationSub() == 2) then
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_2_SHADOW)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 1, 0, 30)
    return dmg
end

return mobskill_object
