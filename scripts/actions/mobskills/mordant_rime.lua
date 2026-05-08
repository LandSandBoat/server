-----------------------------------
-- Mordant Rime
-- Family: Humanoid Dagger Weaponskill
-- Description: Delivers a twofold attack that decreases target's movement speed.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 2
    params.fTP            = { 3.0, 3.0, 3.0 }
    -- params.dex_wSC     = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.chr_wSC     = 0.5 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_2

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 25, 0, 60)
    end

    return info.damage
end

return mobskillObject
