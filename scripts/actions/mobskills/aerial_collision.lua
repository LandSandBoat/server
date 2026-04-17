-----------------------------------
-- Aerial Collision
-- Family: Phuabo
-- Description: Deals physical damage in a cone to targets in front of mob. Additional Effect: Defense Down
-- Note: Defense Down effect decays over time.
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
    params.fTP            = { 1, 1, 1 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.NONE -- TODO: Verify damageType
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- Inversely scales from 50% to 40% defense down depending on TP
        -- TODO: This should decay every 2 ticks per Jimmy's spreadsheet
        -- -38% ~ -50% defense. Decays every 2 ticks by 10% -> 6% -> 6% -> 4% -> 4% -> 4% and then wears off. Lower durations just end without decaying fully.
        local power = 50 - math.min(10, 5 * math.floor((skill:getTP() - 1000) / 1000))

        xi.mobskills.mobStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, power, 0, math.random(45, 75))
    end

    return info.damage
end

return mobskillObject
