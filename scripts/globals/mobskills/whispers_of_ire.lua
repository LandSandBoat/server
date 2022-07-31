-----------------------------------
-- Whispers of Ire
-- Randomly absorbs 2 to 5 attributes from target.
-- Type: Magical
-- Notes: Can also use the ability to target itself and remove all debuffs (whispers_of_ire_self.lua)
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
    local amount = math.random(2, 5)
    local count = 0

    for i = 1, amount do
        -- str down - chr down
        local effectType = math.random(136, 142)

        skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, effectType, 10, 3, 60))

        count = count + 1
    end

    if count > 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return count
end

return mobskill_object
