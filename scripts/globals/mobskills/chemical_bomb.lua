---------------------------------------------
-- Chemical_Bomb
--
-- Description: slow + elegy
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- skillList  54 = Omega
    -- skillList 727 = Proto-Omega
    -- skillList 728 = Ultima
    -- skillList 729 = Proto-Ultima
    local skillList = mob:getMobMod(tpz.mobMod.SKILL_LIST)
    local mobhp = mob:getHPP()
    local phase = mob:getLocalVar("battlePhase")

    if (skillList == 729 and phase < 2) or (skillList == 728 and (mobhp >= 70 or mobhp < 40)) then
        if mob:getLocalVar("nuclearWaste") == 0 then
            return 0
        end
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffectOne = tpz.effect.ELEGY
    local typeEffectTwo = tpz.effect.SLOW

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffectOne, 5000, 0, 120))
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffectTwo, 5000, 0, 120))

    -- This likely doesn't behave like retail.
    return typeEffectTwo
end