-----------------------------------
-- Sanguine Blade
-- Family: Humanoid Sword Weaponskill
-- Description: Drains target's HP. Amount drained varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local tp = skill:getTP()
    local drain = 25 + (tp / 1000) * 25
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 2.75, 2.75, 2.75 }
    -- params.str_wSC       = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC       = 0.5 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element          = xi.element.DARK
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.DARK
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier  = 2
    params.dStatAttackerMod = xi.mod.INT
    params.dStatDefenderMod = xi.mod.INT

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        if not target:isUndead() then
            mob:addHP(info.damage * drain / 100)
        end
    end

    return info.damage
end

return mobskillObject
