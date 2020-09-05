---------------------------------------------
-- Warm-Up
--
-- Description: Enhances accuracy and evasion.
-- Type: Magical (Earth)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- only brown-skinned mamool should use this move
    local mobSkin = mob:getModelId()
    if (mobSkin == 1639 or mobSkin == 1619) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- This is nonsensically overpowering: mob:getMainLvl() + 0.05*mob:getMaxHP()*(skill:getTP()/1000)
    local power = 10 -- Power needs redone with retail MOB VERSION formula not players blue magic
    local EFFECT
    local rand = math.random() -- 0 to 1..
    --[[
        After checking retail this mobskill appeared to grant only
        1 of the 2 effects unlike the blue magic version
    ]]
    if (mob:hasStatusEffect(tpz.effect.ACCURACY_BOOST)) then
        skill:setMsg(MobBuffMove(mob, tpz.effect.EVASION_BOOST, power, 0, 180))
        EFFECT = tpz.effect.EVASION_BOOST
    elseif (mob:hasStatusEffect(tpz.effect.ACCURACY_BOOST)) then
        skill:setMsg(MobBuffMove(mob, tpz.effect.ACCURACY_BOOST, power, 0, 180))
        EFFECT = tpz.effect.ACCURACY_BOOST
    else
        if (rand < 0.5) then
            skill:setMsg(MobBuffMove(mob, tpz.effect.EVASION_BOOST, power, 0, 180))
            EFFECT = tpz.effect.EVASION_BOOST
        else
            skill:setMsg(MobBuffMove(mob, tpz.effect.ACCURACY_BOOST, power, 0, 180))
            EFFECT = tpz.effect.ACCURACY_BOOST
        end
    end

    return EFFECT
end
