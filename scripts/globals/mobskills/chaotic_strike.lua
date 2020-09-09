---------------------------------------------------
-- Chaotic Strike
-- Ramuh delivers a three-hit attack that also stuns target.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)


    local numhits = 3
    local accmod = 1
    local dmgmod = 1.1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    local typeEffect = tpz.effect.STUN
        MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 10)

    return dmg

end
