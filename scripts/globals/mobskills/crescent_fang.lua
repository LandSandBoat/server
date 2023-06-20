-----------------------------------
-- Crescent Fang
-- Fenrir inflicts Paralysis along with a single attack to target.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 5

    local totaldamage = 0
    local damage = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    totaldamage = xi.mobskills.mobFinalAdjustments(damage.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, numhits)

    if damage.hitslanded > 0 then
        target:addStatusEffect(xi.effect.PARALYSIS, 50, 0, 90)
    end

    target:takeDamage(totaldamage, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return totaldamage
end

return mobskillObject
