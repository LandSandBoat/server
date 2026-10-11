-----------------------------------
-- Hoof Volley
-- Family: Hippogryph
-- Description: Deals critical damage to a single target. Additional Effect: Hate Reset, Knockback
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
    params.fTP            = { 4.0, 4.0, 4.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture hate reset type (Enmity wipe vs enmity turned off)
        -- See Antica skill "Sand Trap" for reference
        mob:resetEnmity(target)
    end

    return info.damage
end

return mobskillObject
