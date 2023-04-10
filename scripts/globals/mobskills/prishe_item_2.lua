-----------------------------------
-- Prishe Item 2
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    elseif
        mob:hasStatusEffect(xi.effect.PLAGUE) or
        mob:hasStatusEffect(xi.effect.CURSE_I) or
        mob:hasStatusEffect(xi.effect.MUTE)
    then
        return 0
    elseif math.random() < 0.25 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    if
        mob:hasStatusEffect(xi.effect.PLAGUE) or
        mob:hasStatusEffect(xi.effect.CURSE_I) or
        mob:hasStatusEffect(xi.effect.MUTE)
    then
        -- use Remedy!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 12, false)
        mob:delStatusEffect(xi.effect.PLAGUE)
        mob:delStatusEffect(xi.effect.CURSE_I)
        mob:delStatusEffect(xi.effect.MUTE)
    elseif math.random() < 0.5 then
        -- Carnal Incense!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 10, false)
        mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 1, 0, 30)
    else
        -- Spiritual Incense!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 11, false)
        mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 1, 0, 30)
    end

    return 0
end

return mobskillObject
