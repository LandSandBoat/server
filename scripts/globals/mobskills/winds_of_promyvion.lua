---------------------------------------------
--  Geist Wall
--
--  Description: Party memory erase.
--  Type: Enfeebling
--  Notes: Removes one detrimental magic effect for party members within area of effect.
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
    local dispel = target:eraseStatusEffect()

    if (dispel == tpz.effect.NONE) then
        -- no effect
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(tpz.msg.basic.SKILL_ERASE)
    end

    return dispel
end

return mobskill_object
