---------------------------------------------
-- Gospel_of_the_Lost
--
-- Description: Self-heal (~1000 HP) and erase.
-- Type: Healing
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Accompanied by text
-- "Bask in my glory..."
-- "Mine existence...stretches into infinity..."
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- Lets not heal if we haven't taken any damage..
    if (mob:getHPP() == 100) then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:eraseStatusEffect()
    -- Didn't see any msg for the erase in youtube vids.
    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    -- Assuming its a 4-6% heal based on its max HP and numbers quoted on wiki.
    return MobHealMove(mob, mob:getMaxHP() * (math.random(4, 6) * 0.01))
end
