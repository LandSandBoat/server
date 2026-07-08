-----------------------------------
-- Lux Arrow
-- Trust: Semih Lafihna
-- Notes: Fragmentation/Distortion skillchain properties
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Is this physical or magical?
    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.50, 2.50, 2.50 }   -- TODO: Capture fTPs
    params.element        = xi.element.LIGHT       -- TODO: Capture element
    params.attackType     = xi.attackType.RANGED   -- TODO: Capture attackType
    params.damageType     = xi.damageType.PIERCING -- TODO: Capture damageType
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
