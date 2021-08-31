-----------------------------------
-- Moonlit Charge
-- Fenrir inflicts Blindness along with a single attack (knockback) to target.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 4

    local totaldamage = 0
    local damage = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)
    totaldamage = MobFinalAdjustments(damage.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, numhits)
    target:addStatusEffect(xi.effect.BLINDNESS, 20, 0, 30)
    target:takeDamage(totaldamage, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return totaldamage

end

return mobskill_object
