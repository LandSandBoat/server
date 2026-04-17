-----------------------------------
-- Sudden Lunge
-- Family: Ladybug
-- Description: Deals physical damage to a target. Additional effect: Knockback, Stun.
-- Notes: Reduces Ladybug's HP by 5%-15% whether it hits or not.
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
    params.fTP            = { 1.5, 1.5, 1.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    local currentHP = mob:getHP()
    local newHP = currentHP - (currentHP * (math.random(5, 15) / 100))

    mob:setHP(newHP)
end

return mobskillObject
