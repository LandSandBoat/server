-----------------------------------
-- Discoid
-- Family: Chariots
-- Description: Deals damage spread evenly among party members in range of target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = 1000 / skill:getTotalTargets() -- TODO: Need captures(See below)
    params.fTP            = { 1, 1, 1 }
    params.element        = xi.element.NONE -- TODO: Light or Unaspected?
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.NONE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    -- TODO: Affected by MDB, Shell?

    -- TODO: getPool() or skill:getID() might be better here once captured.
    -- TODO: These values are pulled from online sources. Need official captures from each mob as they likely use different values.
    if mob:getName() == 'Pandemonium_Warden' then
        params.baseDamage = 10000 / skill:getTotalTargets()
    elseif mob:getName() == 'Battleclad_Chariot' then
        params.baseDamage = 4400 / skill:getTotalTargets()
    elseif mob:getName() == 'Battledressed_Chariot' then
        params.baseDamage = 4400 / skill:getTotalTargets()
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
