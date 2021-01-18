---------------------------------------------
-- Tortoise Song
--
-- Description: Removes all status effects in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 20' radial
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local count = target:dispelAllStatusEffect(bit.bor(tpz.effectFlag.SONG, tpz.effectFlag.ROLL))

    if (count == 0) then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
    end

    return count
end

return mobskill_object
