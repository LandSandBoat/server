---------------------------------------------
--  Geotic Breath
--
--  Description: Deals Earth damage to enemies within a fan-shaped area.
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Used only by Ouryu
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/utils")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:hasStatusEffect(tpz.effect.INVINCIBLE) then
        return 1
    elseif not target:isInfront(mob) then
        return 1
    elseif mob:AnimationSub() ~= 0 then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.2, 1.25, tpz.magic.ele.EARTH, 1400)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.9)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.EARTH)
    return dmg
end
