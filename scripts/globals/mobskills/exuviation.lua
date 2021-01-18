-----------------------------------
-- Exuviation
-- Family: Wamoura
-- Type: Healing and Full Erase
-- Range: Self
-- Notes: Erases all negative effects on the mob and heals an amount for each removed.
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
    local baseHeal = 500
    local statusHeal = 300
    local effectCount = 0
    local dispel = mob:eraseStatusEffect()

    while (dispel ~= tpz.effect.NONE)
    do
        effectCount = effectCount + 1
        dispel = mob:eraseStatusEffect()
    end

    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    return MobHealMove(mob, statusHeal * effectCount + baseHeal)
end

return mobskill_object
