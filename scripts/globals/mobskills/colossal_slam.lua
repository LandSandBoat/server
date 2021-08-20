-----------------------------------
-- Colossal Slam
-- Deals damage based off TP.
-- 100% TP: ??? / 250% TP: ??? / 300% TP: ???
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
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0

    -- TODO:
    -- Colossal Slam: Area of Effect magic damage centered around Briareus, wipes shadows.
    -- 1200-1600~ damage and inflicts short-lasting "Zombie" effect, preventing recovery of any HP or MP until it wears off.
    -- Unlike other sources of this status, Colossal Slam's curse cannot be removed with Cursna, Esuna, Sacrifice, or Benediction. Heavy knockback.

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
