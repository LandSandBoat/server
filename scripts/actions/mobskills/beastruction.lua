-----------------------------------
-- Beastruction
-- Family: Yztarg
-- Description: Delivers a physical attack.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = target:getHP() - 1 -- TODO: JPWiki says this reduces HP to 1 (Similar to Throat Stab). Need captures
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING -- TODO: Capture damageType
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior
    params.skipFSTR       = true
    params.skipPDIF       = true
    params.skipParry      = true
    params.skipGuard      = true
    params.skipBlock      = true

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: JPWiki says this inflicts Weight. Need to capture power/duration
        -- TODO: JPwiki says this removes all equipment.
        -- TODO: JPWiki states this inflicts encumbereance (Can equip/unequip equipment) (60s)
    end

    return info.damage
end

return mobskillObject
