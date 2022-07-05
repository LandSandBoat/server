-----------------------------------
-- Whispers of Ire
-- Randomly absorbs 2 to 5 attributes from target.
-- Type: Magical
-- Notes: Can also use the ability to target itself and remove all debuffs
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
    -- Can either drain buffs from target or target self to remove debuffs
    local chance = math.random(1,3)

    -- Drain buffs
    if chance > 1 then
        local amount = math.random(2, 5)
        local effectFirst
        local count

        for i = 1, amount do
            local effect = mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
            if effect ~= 0 then
                count = count + 1
            end
        end

        if count > 0 then
            skill:setMsg(xi.msg.basic.EFFECT_DRAINED, count)
        else
            skill:setMsg(xi.msg.basic.SKILL_MISS)
        end

        return count
    -- Erase debuffs
    else
        mob:eraseAllStatusEffect()
        local count = target:dispelAllStatusEffect()
        count = count + target:eraseAllStatusEffect()

        if (count == 0) then
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        else
            skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        end
    end

end

return mobskill_object
