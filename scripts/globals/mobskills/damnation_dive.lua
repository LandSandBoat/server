-----------------------------------
-- Damnation Dive
--
-- Description: Dives into a single target. Additional effect: Knockback + Stun
-- Type: Physical
-- Utsusemi/Blink absorb: 3 shadow
-- Range: Melee
-- Notes: Used instead of Gliding Spike by certain notorious monsters.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

-----------------------------------
-- onMobSkillCheck
-- Check for Grah Family id 122, 123, 124
-- if not in Bird form, then ignore.
-----------------------------------
mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if ((mob:getFamily() == 122 or mob:getFamily() == 123 or mob:getFamily() == 124) and mob:getAnimationSub() ~= 3) then
        return 1
    else
        return 0
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = .8
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    local typeEffect = xi.effect.STUN

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskill_object
