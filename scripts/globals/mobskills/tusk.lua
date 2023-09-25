-----------------------------------
-- Tusk
-- Deals damage to a single target. Additional effect: Knockback
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local damageMod = 1

    if skill:getID() == 1859 then -- Nightmare Bugard - Additional damage
        damageMod = 2
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, damageMod, xi.mobskills.magicalTpBonus.NO_EFFECT, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end

return mobskillObject
