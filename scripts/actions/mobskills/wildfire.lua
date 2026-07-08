-----------------------------------
-- Wildfire
-- Family: Humanoid Marksmanship Weaponskill
-- Description: Deals fire elemental damage. Enmity generation varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 5.5, 5.5, 5.5 }
    -- params.agi_wSC          = 0.6 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element          = xi.element.FIRE
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.FIRE
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.dStatMultiplier  = 2
    params.dStatAttackerMod = xi.mod.AGI
    params.dStatDefenderMod = xi.mod.INT

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
