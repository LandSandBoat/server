-----------------------------------
-- Soul Accretion
-- Gaze dispel
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
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
    local count = math.random(1,3)
    local effect = 0

    for i = 1, count do
        if target:dispelStatusEffect() then
            effect = effect +1
        end
    end

    if effect > 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end

return mobskill_object
