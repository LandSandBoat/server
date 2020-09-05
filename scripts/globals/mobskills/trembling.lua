---------------------------------------------
--  Trembling
--
--  Description: Deals physical damage to enemies within an area of effect. Additional effect: Dispel
--  Type: Physical
--  Wipes Shadows
--  Range: 10' radial
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 4
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, MOBPARAM_WIPE_SHADOWS)
   local dispelled = math.random(2, 3)

   if (info.hitslanded ~= 0) then
      for i=1, dispelled do
         target:dispelStatusEffect()
      end
   end

   -- TODO: Dispelled messages.  No examples of damage+dispel working to crib notes from.

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    return dmg
end
