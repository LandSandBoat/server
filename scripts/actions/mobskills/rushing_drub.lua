-----------------------------------
-- Rushing Drub
-- Family: Mamool Ja
-- Description: Delivers a fourfold attack on a single target.
-- Notes: Only used by Mamool Ja with staves.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() == 0 and
        (mob:getMainJob() == xi.job.BLM or mob:getMainJob() == xi.job.WHM) -- TODO: Set proper skill lists
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 4
    params.fTP            = { 0.75, 0.75, 0.75 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
