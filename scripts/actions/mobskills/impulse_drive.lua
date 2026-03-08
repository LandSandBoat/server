-----------------------------------
-- Impulse Drive
-- Delivers a two-hit attack
-- Type: Physical
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 2
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.ATK_VARIES, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    if dmg > 0 then
        local resist = applyResistanceAddEffect(mob, target, xi.element.ICE, 0)
        if not target:hasStatusEffect(xi.effect.BIND) and resist >= 0.5 then
            local duration = (5 + 5) * resist
            target:addStatusEffect(xi.effect.BIND, { power = 1, duration = duration, origin = mob })
        end
    end

    return dmg
end

return mobskillObject
