-----------------------------------
-- Magma_Hoplon
-- Covers the user in fiery spikes and absorbs damage. Enemies that hit it take fire damage.
-- Stoneskin portion cannot be removed with dispel.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffectOne = xi.effect.STONESKIN
    local typeEffectTwo = xi.effect.BLAZE_SPIKES
    local randy = math.random(20, 30)
    skill:setMsg(MobBuffMove(mob, typeEffectOne, 1000, 0, 300))
    MobBuffMove(mob, typeEffectTwo, randy, 0, 180)
    local effect1 = mob:getStatusEffect(typeEffectOne)
    effect1:unsetFlag(xi.effectFlag.DISPELABLE)

    return typeEffectOne
end

return mobskill_object
