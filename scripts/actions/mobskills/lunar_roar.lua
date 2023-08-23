-----------------------------------
-- Lunar Roar
-- Fenrir removes up to 10 beneficial status effects from enemies within Area of Effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local effects = target:getStatusEffects()
    local num = 0

    for i, effect in pairs(effects) do
        -- check mask bit for xi.effectFlag.DISPELABLE
        if
            utils.mask.getBit(effect:getFlag(), 0) and
            effect:getEffectType() ~= xi.effect.RERAISE and
            num < 10
        then
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
