-----------------------------------
-- Geirskogul
-- Family: Humanoid Polearm Weaponskill
-- Description: Grants Shock Spikes.
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
    -- params.agi_wSC     = 0.6 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        mob:addStatusEffect(xi.effect.SHOCK_SPIKES, { power = 10, duration = math.floor(20 * skill:getTP() / 1000), origin = mob })
    end

    return info.damage
end

return mobskillObject
