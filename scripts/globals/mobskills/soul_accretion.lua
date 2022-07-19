-----------------------------------
-- Soul Accretion
-- Drains 3 effects from target
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
    -- try to drain buff
    local effect1 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effect2 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    local effect3 = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)

    if effect1 ~= 0 then
        local count = 1
        if effect2 ~= 0 then
            count = count + 1
        end
        if effect3 ~= 0 then
            count = count + 1
        end

        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
        return count
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end
end

return mobskill_object
