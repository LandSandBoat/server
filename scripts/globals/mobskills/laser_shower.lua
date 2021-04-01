-----------------------------------
-- Laser_Shower
--
-- Description: Fires several lasers into a fan-shaped area of effect. Additional effect: Defense Down
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes:
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local currentForm = mob:getLocalVar("form") -- this var is only set for proto-omega

    if (currentForm == 2) then
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.2, 1.25, xi.magic.ele.LIGHT, 1600)
    local dis = ((mob:checkDistance(target)*2) / 20)

    dmgmod = dmgmod * dis
    dmgmod = utils.clamp(dmgmod, 50, 1600)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)

    MobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 25, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.LIGHT)
    return dmg
end

return mobskill_object
