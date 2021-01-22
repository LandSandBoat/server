-----------------------------------
-- Perfect Defense
--
-- Description: Reduces damage taken and greatly increases resistance to most status tpz.effect.
-- Type: Enhancing
-- Can be dispelled: No
-- Range: Self
-- Notes:
-- Grants immunity to either physical, magical, or ranged damage.
-- Randomly switches immunities starting at 10% health. Accompanied by text
-- "Cease thy struggles...
-- I am immutable...indestructible...impervious...immortal..."
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    MobBuffMove(mob, tpz.effect.PERFECT_DEFENSE, 1, 0, skill:getParam())

    skill:setMsg(tpz.msg.basic.USES)
    return tpz.effect.PERFECT_DEFENSE
end

return mobskill_object
