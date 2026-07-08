-----------------------------------
-- Last Stand
-- Family: Humanoid Marksmanship Weaponskill
-- Description: Damage varies with TP. Delivers a twofold attack, ammunition permitting.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = mob:getWeaponDmg()
    params.numHits            = 2
    params.fTP                = { 2.0, 2.125, 2.25 }
    params.fTPSubsequentHits  = { 2.0, 2.125, 2.25 }
    -- params.agi_wSC            = 0.85 -- TODO: Capture if mobskill weaponskills have wSC.
    params.skipParry          = true
    params.skipGuard          = true
    params.skipBlock          = true
    params.attackType         = xi.attackType.RANGED
    params.damageType         = xi.damageType.PIERCING
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_2

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
