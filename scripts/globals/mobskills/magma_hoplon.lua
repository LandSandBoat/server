-----------------------------------
-- Magma_Hoplon
-- Covers the user in fiery spikes and absorbs damage. Enemies that hit it take fire damage.
-- Stoneskin portion cannot be removed with dispel.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffectOne = xi.effect.STONESKIN
    local typeEffectTwo = xi.effect.BLAZE_SPIKES
    local randy = math.random(20, 30)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffectOne, 1000, 0, 300))
    xi.mobskills.mobBuffMove(mob, typeEffectTwo, randy, 0, 180)
    local effect1 = mob:getStatusEffect(typeEffectOne)
    effect1:unsetFlag(xi.effectFlag.DISPELABLE)

    return typeEffectOne
end

return mobskillObject
