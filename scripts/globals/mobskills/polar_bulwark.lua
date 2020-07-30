---------------------------------------------
-- Polar Bulwark
--
-- Description: Grants a Magic Shield effect for a time.
-- Type: Enhancing
--
-- Range: Self
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getFamily() == 316) then
        local mobSkin = mob:getModelId()

        if (mobSkin == 1796) then
            return 0
        else
            return 1
        end
    end

    if (mob:AnimationSub() == 0) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)

    -- addEx to pervent dispel
    mob:addStatusEffectEx(tpz.effect.MAGIC_SHIELD, 0, 1, 0, 45)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    if (mob:getFamily() == 313) then -- Tinnin follows this up immediately with Nerve Gas
        mob:useMobAbility(1580)
    end

    return tpz.effect.MAGIC_SHIELD
end
