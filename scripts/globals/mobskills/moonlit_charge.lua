-----------------------------------
-- Moonlit Charge
-- Fenrir inflicts Blindness along with a single attack (knockback) to target.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 4

    local totaldamage = 0
    local damage = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    totaldamage = xi.mobskills.mobFinalAdjustments(damage.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, numhits)
    target:addStatusEffect(xi.effect.BLINDNESS, 20, 0, 30)
    target:takeDamage(totaldamage, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return totaldamage
end

return mobskillObject
