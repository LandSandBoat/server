---------------------------------------------------
-- Queasyshroom
-- Additional effect: Fires a mushroom cap, dealing damage to a single target. Additional effect: paralysis.
-- Range is 14.7 yalms.
-- Piercing damage Ranged Attack.
-- Secondary modifiers: INT: 20%.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getMobMod(tpz.mobMod.VAR) == 1) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)

    mob:setMobMod(tpz.mobMod.VAR, 2)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, info.hitslanded)

    local typeEffect = tpz.effect.PARALYSIS

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 35, 0, 180)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    return dmg
end
