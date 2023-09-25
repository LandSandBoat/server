-----------------------------------
-- Magma_Hoplon
-- Covers the user in fiery spikes and absorbs damage. Enemies that hit it take fire damage.
-- Stoneskin portion cannot be removed with dispel.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.STONESKIN) then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffectOne = xi.effect.STONESKIN
    local typeEffectTwo = xi.effect.BLAZE_SPIKES
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffectOne, 750, 0, 300))
    xi.mobskills.mobBuffMove(mob, typeEffectTwo, 20, 0, 900)
    local effect1 = mob:getStatusEffect(typeEffectOne)
    effect1:unsetFlag(xi.effectFlag.DISPELABLE)

    return typeEffectOne
end

return mobskillObject
