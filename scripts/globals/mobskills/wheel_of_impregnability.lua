-----------------------------------
-- Wheel of Impregnability
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or mob:hasStatusEffect(xi.effect.MAGIC_SHIELD)) then
        return 1
    end
    mob:showText(mob, ID.text.PROMATHIA_TEXT + 5)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    -- local typeEffect = xi.effect.PHYSICAL_SHIELD

    mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 0, 0, 0)
    mob:setAnimationSub(1)

    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.PHYSICAL_SHIELD
end

return mobskill_object
