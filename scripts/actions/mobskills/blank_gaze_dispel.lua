-----------------------------------
-- Blank Gaze
-- Gaze dispel
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if not target:isFacing(mob) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    local tp = skill:getTP()
    local maxDispel = utils.clamp(math.floor(tp / 1000), 1, 3)
    local effectCount = 0

    for _ = 1, maxDispel do
        local effect = target:dispelStatusEffect()
        if effect == xi.effect.NONE then
            break
        end

        effectCount = effectCount + 1
    end

    if effectCount == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    return effectCount
end

return mobskillObject
