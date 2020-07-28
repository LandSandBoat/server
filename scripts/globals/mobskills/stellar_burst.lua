---------------------------------------------------
-- Stellar Burst
-- A starburst damages targets in an area of effect. Additional effect: Silence
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg(), tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_3_SHADOW)
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 30)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    mob:resetEnmity(target)
    return dmg
end
