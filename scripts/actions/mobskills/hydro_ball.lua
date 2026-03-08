-----------------------------------
-- Hydroball
-- Family: Sahagin
-- Description: Deals Water damage to targets in a fan-shaped area of effect. Additional Effect: STR Down
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 1.5, 1.5, 1.5 }
    params.element         = xi.element.WATER
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.WATER
    params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: JP Wiki states this scales off mob level. Also observed in captures.
        -- https://discord.com/channels/443544205206355968/674750598939279400/1367925653667840250

        -- Need more captures to determine proper forumula.

        -- There are at least 2 different versions of this move. Tan sahagin use skillID 771 while blue uses 772.
        -- Tan models seem to have a slightly weaker STR down.

        -- Captures had -17 STR at Level 35 and reaching -32 STR at 75.
        local power = math.ceil((mob:getMainLvl() * 3 + 31) / 8) -- Linear scaling formula based on capture data until we get more captures at varying mob levels

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, 9, 120)
    end

    return info.damage
end

return mobskillObject
