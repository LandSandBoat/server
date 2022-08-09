-----------------------------------
-- Wild Ginseng
--
-- Description: Gives mob Blink
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local duration = math.random(210, 270)

    mob:addStatusEffect(xi.effect.BLINK, 3, 0, duration)
    mob:addStatusEffect(xi.effect.PROTECT, 60, 0, duration)
    mob:addStatusEffect(xi.effect.SHELL, 60, 0, duration)
    mob:addStatusEffect(xi.effect.HASTE, 2000, 0, duration) -- 20% haste
    mob:addStatusEffect(xi.effect.REGEN, 30, 0, duration)

    mob:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.BLINK)
end

return mobskill_object
