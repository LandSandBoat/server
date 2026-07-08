-----------------------------------
-- Guillotine
-- Family: Humanoid Scythe Weaponskill
-- Description: Delivers a fourfold attack that silences target. Duration of silence varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 4
    params.fTP            = { 0.875, 0.875, 0.875 }
    -- params.str_wSC     = 0.25 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC     = 0.25 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, math.floor(30 + 3 * skill:getTP() / 100))
    end

    return info.damage
end

return mobskillObject
