-----------------------------------
-- Nutrient Absorption
-- Family: Euvhi
-- Description: Drains HP of target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = 300
    params.fTP                = { 1, 1, 1 } -- TODO: Jimmayus spreadsheet says this scales with TP. Need captures for scaling.
    params.element            = xi.element.NONE
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.NONE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipMagicBonusDiff = true
    params.dStatMultiplier    = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))
    end

    return info.damage
end

return mobskillObject
