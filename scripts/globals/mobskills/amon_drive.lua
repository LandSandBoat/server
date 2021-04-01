-----------------------------------
--  Amon Drive
--
--  Description: Performs an area of effect weaponskill. Additional effect: Paralysis + Petrification + Poison
--  Type: Physical
--  2-3 Shadows?
--  Range: Melee range radial

-- Special weaponskill unique to Ark Angel TT. Deals ~100-400 damage.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, MOBPARAM_3_SHADOW)

   MobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60)
   MobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, math.random(8, 15) + mob:getMainLvl()/3)
   MobStatusEffectMove(mob, target, xi.effect.POISON, math.ceil(mob:getMainLvl() / 5), 3, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskill_object
