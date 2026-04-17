-----------------------------------
-- Powder Keg
-- Family: Humanoid (Lion)
-- Description: Conal physical damage. Additional Effect: Defense Down, Knockback, Magic Defense Down
-- Skillchain Properties: Fusion/Compression
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
    params.fTP            = { 0.3, 0.3, 0.3 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 20, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 20, 0, 60)
    end

    return info.damage
end

return mobskillObject
