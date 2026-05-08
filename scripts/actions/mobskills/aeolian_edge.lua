-----------------------------------
-- Aeolian Edge
-- Family: Humanoid Dagger Weaponskill
-- Description: Delivers an area attack that deals wind elemental damage. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- mob:messageBasic(xi.msg.basic.READIES_WS, 0, 41)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 2.75, 3.5, 4.0 }
    -- params.dex_wSC       = 0.28 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.int_wSC       = 0.28 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element          = xi.element.WIND
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.WIND
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier  = 1
    params.dStatAttackerMod = xi.mod.INT
    params.dStatDefenderMod = xi.mod.INT

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
