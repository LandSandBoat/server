---------------------------------------------
-- Laser_Shower
--
-- Description: Fires several lasers into a fan-shaped area of effect. Additional effect: Defense Down
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local currentForm = mob:getLocalVar("form") -- this var is only set for proto-omega

    if (currentForm == 2) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.2, 1.25, tpz.magic.ele.LIGHT, 1600)
    local dis = ((mob:checkDistance(target)*2) / 20)

    dmgmod = dmgmod * dis
    dmgmod = utils.clamp(dmgmod, 50, 1600)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)

    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.DEFENSE_DOWN, 25, 0, 60)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.LIGHT)
    return dmg
end
