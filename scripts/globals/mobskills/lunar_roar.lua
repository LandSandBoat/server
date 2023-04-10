-----------------------------------
-- Lunar Roar
-- Fenrir removes up to 10 beneficial status effects from enemies within Area of Effect.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
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
            effect:getType() ~= xi.effect.RERAISE and
            num < 10
        then
            target:delStatusEffect(effect:getType())
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
