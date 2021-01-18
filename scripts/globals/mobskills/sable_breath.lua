---------------------------------------------
--  Sable Breath
--
--  Description: Deals darkness damage to enemies within a fan-shaped area.
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Used only by Vrtra and Azdaja
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/utils")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if not target:isInfront(mob, 128) then
        return 1
    elseif mob:getAnimationSub() ~= 0 then
        return 1
    end

    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.2, 1.25, tpz.magic.ele.DARK, 1400)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.9)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.DARK)
    return dmg
end

return mobskill_object
