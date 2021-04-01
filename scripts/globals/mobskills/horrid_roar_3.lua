-----------------------------------
-- Horrid Roar (Tiamat, Jormungand, Vrtra, Ouryu)
-- Dispels all buffs including food. Lowers Enmity.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES)) then
        return 1
    elseif (mob:hasStatusEffect(xi.effect.INVINCIBLE)) then
        return 1
    elseif (mob:hasStatusEffect(xi.effect.BLOOD_WEAPON)) then
        return 1
    elseif (target:isBehind(mob, 48) == true) then
        return 1
    elseif (mob:getAnimationSub() == 1) then
        return 1
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dispel =  target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))

    if (dispel == 0) then
        -- no effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    mob:lowerEnmity(target, 70)

    return dispel
end

return mobskill_object
