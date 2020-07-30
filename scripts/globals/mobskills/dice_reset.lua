---------------------------------------------
-- Goblin Dice
--
-- Description: Reset recasts on abilities
-- Type: Physical (Blunt)
--
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    target:resetRecasts()

    skill:setMsg(tpz.msg.basic.ABILITIES_RECHARGED)

    return 1
end
