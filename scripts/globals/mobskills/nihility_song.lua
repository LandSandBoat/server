---------------------------------------------
-- Nihility Song
-- Family: Hippogryph
-- Description: A song dispels a positive effect in an area of effect, including food.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Radial 12.5'
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dispel =  target:dispelStatusEffect(bit.bor(tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD))

    if (dispel == tpz.effect.NONE) then
        -- no effect
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(tpz.msg.basic.SKILL_ERASE)
    end

    return dispel
end

return mobskill_object
