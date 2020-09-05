---------------------------------------------
--  Dragonfall
--
--  Description: Deals damage to players an area of effect. Additional effect: Bind
--  Type: Physical
--  2-3 Shadows
--  Range: Melee
-- Special weaponskill unique to Ark Angel GK. Deals ~100-300 damage.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

   -- TODO: Can skillchain?  Unknown property.

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.7
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_2_SHADOW)

   MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, 30)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    return dmg
end
