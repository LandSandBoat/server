---------------------------------------------
-- Shadowstitch
-- Binds target.
-- Type: Physical
-- Range: Melee
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 2, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
        local resist = xi.magic.applyResistanceAddEffect(mob, target, xi.magic.ele.ICE, xi.effect.BIND, 0)
        if not target:hasStatusEffect(xi.effect.BIND) and resist >= 0.5 then
            local duration = (5 + 5) * resist
            target:addStatusEffect(xi.effect.BIND, 1, 0, duration)
        end
    end

    return dmg
end

return mobskillObject
