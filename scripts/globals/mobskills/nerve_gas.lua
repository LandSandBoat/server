-----------------------------------
-- Nerve Gas
--
-- Description: Inflicts curse and powerful poison xi.effect.
-- Type: Magical
-- Wipes Shadows
-- Range: 10' Radial
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 316 then -- PW
        local mobSkin = mob:getModelId()
        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    elseif mob:getFamily() == 313 then -- Tinnin can use at will
        return 0
    else
        if mob:getAnimationSub() == 0 then
            return 0
        else
            return 1
        end
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 50, 0, 420))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 20, 3, 60)
    return xi.effect.CURSE_I
end

return mobskillObject
