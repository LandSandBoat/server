-----------------------------------
-- Pyrrhic Kleos
-- Family: Humanoid Dagger Weaponskill
-- Description: Delivers a fourfold attack that lowers target's evasion. Duration of effect varies with TP.
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
    params.fTP            = { 1.5, 1.5, 1.5 }
    -- params.str_wSC     = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.dex_wSC     = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 10, 0, math.floor(6 * skill:getTP() / 100))
    end

    return info.damage
end

return mobskillObject
