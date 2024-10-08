-----------------------------------
-- Diamondhide
--
-- Description: Gives the effect of "Stoneskin."
-- Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 800
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, power, 0, 300))

    local effect = mob:getStatusEffect(xi.effect.STONESKIN)
    if effect then
        effect:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    return xi.effect.STONESKIN
end

return mobskillObject
