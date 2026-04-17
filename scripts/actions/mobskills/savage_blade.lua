-----------------------------------
-- Savage Blade
-- Family: Humanoid Sword Weaponskill
-- Description: Delivers a twofold attack. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() ~= xi.mobPool.QUBIA_ARENA_TRION then -- TODO: Should this be limited to Trion?
        mob:messageBasic(xi.msg.basic.READIES_WS, 0, 42)
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.0, 2.0, 2.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_2

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    if mob:getPool() == xi.mobPool.QUBIA_ARENA_TRION then -- Trion@QuBia_Arena only
        target:showText(mob, zones[xi.zone.QUBIA_ARENA].text.SAVAGE_LAND)
    end

    return info.damage
end

return mobskillObject
