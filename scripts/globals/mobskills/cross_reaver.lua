-----------------------------------
--  Cross Reaver
--
--  Description: Deals high damage to players in a fan-shaped area. Additional effect: Stun
--  Type: Physical
--  ? ? ? (No data offered)
--  Range: Melee

-- Special weaponskill unique to Ark Angel HM. Deals ~500-900 damage.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

   -- TODO: Can skillchain?  Unknown property.

    local numhits = 2
    local accmod = 1
    local dmgmod = 4
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, MOBPARAM_2_SHADOW)

   MobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

   target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskill_object
