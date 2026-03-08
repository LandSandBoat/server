-----------------------------------
-- Mana Storm
-- Family: Dynamis Lord
-- Description: Steals MP from players within range.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage           = mob:getMainLvl() + 2 -- TODO: Capture base damage. Other MP Drains are often Level - 2
    params.fTP                  = { 3, 3, 3 } -- TODO: Capture fTP
    params.element              = xi.element.NONE
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.NONE
    params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipDamageAdjustment = true
    params.skipMagicBonusDiff   = true
    params.skipStoneSkin        = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.MP, info.damage))
    end

    return info.damage
end

return mobskillObject
