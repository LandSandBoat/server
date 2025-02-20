-----------------------------------
-- Skewer
-- Delivers a three-hit attack
-- Type: Physical
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, 3, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    if dmg > 0 then
        local resist = applyResistanceAddEffect(mob, target, xi.element.ICE, 0)
        if not target:hasStatusEffect(xi.effect.BIND) and resist >= 0.5 then
            local duration = (5 + 5) * resist
            target:addStatusEffect(xi.effect.BIND, 1, 0, duration)
        end
    end

    return dmg
end

return mobskillObject
