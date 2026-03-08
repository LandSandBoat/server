-----------------------------------
-- Soul Drain
-- Family: Demons (Kindred)
-- Description: Steals an enemy's HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Jimmayus spreadsheet says this is physical? Need testing.
    params.baseDamage         = mob:getMainLvl() + 2
    params.fTP                = { 1.5, 1.5, 1.5 }
    params.element            = xi.element.NONE
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.NONE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipMagicBonusDiff = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))
    end

    return info.damage
end

return mobskillObject
