-----------------------------------
-- Drop Hammer
-- Family: Troll
-- Description: Deals AoE physical damage to targets in range. Additional Effect: Bind
-- Notes: Only used by "destroyers" (carrying massive warhammers).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.4, 2.4, 2.4 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType, { breakBind = false })

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)

        if mob:getPool() == xi.mobPool.FAHRAFAHR_THE_BLOODIED then
            mob:resetEnmity(target)
        end
    end

    return info.damage
end

return mobskillObject
