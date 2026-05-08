-----------------------------------
-- Rampage
-- Family: Humanoid Axe Weaponskill
-- Description: Delivers a fivefold attack. Chance of critical hit varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage        = mob:getWeaponDmg()
    params.numHits           = 5
    params.fTP               = { 0.5, 0.5, 0.5 }
    -- params.str_wSC        = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.canCrit           = true
    params.criticalChance    = { 0.10, 0.30, 0.50 }
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_5

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
