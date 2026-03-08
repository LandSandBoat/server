-----------------------------------
-- Lunar Roar
-- Fenrir removes up to 6 beneficial status effects from enemies within Area of Effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effects = target:getStatusEffects()
    local num = 0

    for _, effect in pairs(effects) do
        if num >= 6 then
            break
        end

        if bit.band(effect:getEffectFlags(), xi.effectFlag.DISPELABLE) ~= 0 then
            target:delStatusEffect(effect:getEffectType())
            num = num + 1
        end
    end

    skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    if num == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return num
end

return mobskillObject
