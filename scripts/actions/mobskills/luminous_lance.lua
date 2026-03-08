-----------------------------------
--  Luminous Lance
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)

    if dmg > 0 then
        -- Cannot be resisted
        target:setAnimationSub(3)
        target:addStatusEffect(xi.effect.TERROR, { duration = 30, origin = mob })
    end

    return dmg
end

return mobskillObject
