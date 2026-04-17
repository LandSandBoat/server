-----------------------------------
-- Rhinowrecker
-- Family: Beetle
-- Description : Powerful physical attack to enemies in a cone. Additional Effect: Defense Down, Knockback
-- Range: Cone originating from caster.
-- TODO: Verify animation ID, skill is currently commented out in mob_skills.sql
-- Defense down power is NM specific. Abyssea only move. Needs captures.
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
    params.fTP            = { 3.0, 3.0, 3.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: DEF Down power varies depending on mob
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 25, 0, 180)
    end

    return info.damage
end

return mobskillObject
