-----------------------------------
-- Blood Drain
-- Family: Giant Bats
-- Description: Steals an enemy's HP. Ineffective against undead.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = mob:getMainLvl() + 2
    params.fTP                = { 1.00, 2.00, 2.84 } -- Note: 2.84 fTP anchor is actually around 2700TP~.
    params.element            = xi.element.NONE
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.NONE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipMagicBonusDiff = true

    -- Projected DMG 48, 96, 135
    -- Check 2334

    -- Asanbosam (Pool ID 256) uses a modified Blood Drain that ignores shadows
    if mob:getPool() == xi.mobPool.ASANBOSAM then
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage, info.attackType, info.damageType))
    end

    return info.damage
end

return mobskillObject
