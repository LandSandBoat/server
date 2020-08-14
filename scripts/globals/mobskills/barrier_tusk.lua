---------------------------------------------
-- Barrier Tusk
-- Enhances defense and magic defense
-- Marids will only use Barrier Tusk if at least one of their tusks remain unbroken
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == 0 then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)

    MobBuffMove(mob, tpz.effect.MAGIC_DEF_BOOST, 30, 0, 90)
    skill:setMsg(MobBuffMove(mob, tpz.effect.DEFENSE_BOOST, 30, 0, 90))

    return tpz.effect.DEFENSE_BOOST
end
