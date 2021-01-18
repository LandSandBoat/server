-----------------------------------
---  Shadow Spread
-----------------------------------
---  Description: A dark shroud renders any nearby targets blinded, asleep, and cursed.
-----------------------------------
---------------------------------------------
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
    local typeEffect = 0
    local currentMsg = tpz.msg.basic.NONE
    local msg = tpz.msg.basic.NONE

    msg = MobStatusEffectMove(mob, target, tpz.effect.CURSE_I, 25, 0, 300)

    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.CURSE_I
        currentMsg = msg
    end

    msg = MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 20, 0, 180)

    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.BLINDNESS
        currentMsg = msg
    end

    msg = MobStatusEffectMove(mob, target, tpz.effect.SLEEP_I, 1, 0, 30)

    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.SLEEP_I
        currentMsg = msg
    end

    skill:setMsg(currentMsg)

    return typeEffect
end

return mobskill_object
