-----------------------------------
-- Diamondhide
--
-- Description: Gives the effect of "Stoneskin."
-- Type: Magical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 800
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, power, 0, 300))

    local effect = mob:getStatusEffect(xi.effect.STONESKIN)
    effect:delEffectFlag(xi.effectFlag.DISPELABLE)

    return xi.effect.STONESKIN
end

return mobskillObject
