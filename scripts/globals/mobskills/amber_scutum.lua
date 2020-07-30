---------------------------------------------
-- Amber Scutum
-- Family: Wamouracampa
-- Description: Increases defense.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local status = mob:getStatusEffect(tpz.effect.DEFENSE_BOOST)
    local power = 100
    if status ~= nil then
        -- This is as accurate as we get until effects applied by mob moves can use subpower..
        power = status:getPower() * 2
    end

    skill:setMsg(MobBuffMove(mob, tpz.effect.DEFENSE_BOOST, power, 0, 60))

    return tpz.effect.DEFENSE_BOOST
end
