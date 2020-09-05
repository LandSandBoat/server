---------------------------------------------
-- Nerve Gas
--
-- Description: Inflicts curse and powerful poison tpz.effect.
-- Type: Magical
-- Wipes Shadows
-- Range: 10' Radial
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)

    if (mob:getFamily() == 316) then -- PW
        local mobSkin = mob:getModelId()
        if (mobSkin == 1796) then
            return 0
        else
            return 1
        end
    elseif (mob:getFamily() == 313) then -- Tinnin can use at will
        return 0
    else
        if (mob:AnimationSub() == 0) then
            return 0
        else
            return 1
        end
    end

end

function onMobWeaponSkill(target, mob, skill)

    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.CURSE_I, 50, 0, 420))
    MobStatusEffectMove(mob, target, tpz.effect.POISON, 20, 3, 60)
    return tpz.effect.CURSE_I
end
