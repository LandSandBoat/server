-----------------------------------
-- Tornado Kick
-- Family: Humanoid Hand to Hand Weaponskill
-- Description: Delivers a threefold attack. Damage varies with TP.
-- TODO: Effected by Kick Attacks bonuses?
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3
    params.fTP            = { 2.25, 2.75, 3.5 }
    --params.str_wSC      = 0.32 -- TODO: Capture if mobskill weaponskills have wSC.
    --params.vit_wSC      = 0.32 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
