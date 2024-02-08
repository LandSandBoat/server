-----------------------------------
-- Magma_Hoplon
-- Covers the user in fiery spikes and absorbs damage. Enemies that hit it take fire damage.
-- Stoneskin portion cannot be removed with dispel.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, 1000, 0, 300))
    xi.mobskills.mobBuffMove(mob, xi.effect.BLAZE_SPIKES, math.random(20, 30), 0, 180)
    local effect1 = mob:getStatusEffect(xi.effect.STONESKIN)
    effect1:delEffectFlag(xi.effectFlag.DISPELABLE)

    return xi.effect.STONESKIN
end

return mobskillObject
