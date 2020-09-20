---------------------------------------------
-- Spirit Absorption
-- Attempts to absorb one buff from a single target, or otherwise steals HP.
-- Type: Magical
-- Utsusemi/Blink absorb: 1 Shadows
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local basehp = skill:getParam()
    if (basehp == 0) then
        basehp = 50
    end

    -- time to drain HP. 50-100
    local power = math.random(0, 51) + basehp
    local dmg = MobFinalAdjustments(power, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_1_SHADOW)

    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))

    return dmg
end
