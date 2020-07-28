---------------------------------------------
-- Prishe Item 2
---------------------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) or target:hasStatusEffect(tpz.effect.MAGIC_SHIELD)) then
        return 1
    elseif (mob:hasStatusEffect(tpz.effect.PLAGUE) or mob:hasStatusEffect(tpz.effect.CURSE_I) or mob:hasStatusEffect(tpz.effect.MUTE)) then
        return 0
    elseif (math.random() < 0.25) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.NONE)
    if (mob:hasStatusEffect(tpz.effect.PLAGUE) or mob:hasStatusEffect(tpz.effect.CURSE_I) or mob:hasStatusEffect(tpz.effect.MUTE)) then
        -- use Remedy!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 12, false)
        mob:delStatusEffect(tpz.effect.PLAGUE)
        mob:delStatusEffect(tpz.effect.CURSE_I)
        mob:delStatusEffect(tpz.effect.MUTE)
    elseif (math.random() < 0.5) then
        -- Carnal Incense!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 10, false)
        mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 0, 0, 30)
    else
        -- Spiritual Incense!
        mob:messageText(mob, ID.text.PRISHE_TEXT + 11, false)
        mob:addStatusEffect(tpz.effect.MAGIC_SHIELD, 0, 0, 30)
    end
    return 0
end
