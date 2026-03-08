-----------------------------------
-- Crispy Candle (Self)
-- Family: Moblin
-- Description: Crispy Candle backfires, dealing Fire damage to mob.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = mob:getMainLvl() + 2
    params.fTP                = { 3.5, 3.5, 3.5 }
    params.element            = xi.element.FIRE
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.FIRE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier    = 1
    params.resistTierOverride = 0.25 -- 1/4 Resist
    -- Jimmayus spreadsheet stats Crispy Candle backfire is a 1/4 resist.
    -- https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?pli=1&gid=57955395#gid=57955395&range=A1102

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)
    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
