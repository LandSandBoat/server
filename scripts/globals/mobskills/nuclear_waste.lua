---------------------------------------------------
--  Nuclear Waste
--  Description: Reduces elemental resistances by 50 to players in range.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target,mob,skill)
    -- skillList  54 = Omega
    -- skillList 727 = Proto-Omega
    -- skillList 728 = Ultima
    -- skillList 729 = Proto-Ultima
    local skillList = mob:getMobMod(tpz.mobMod.SKILL_LIST)
    local mobhp = mob:getHPP()
    local phase = mob:getLocalVar("battlePhase")

    if ((skillList == 729 and phase >= 1 and phase <= 2) or (skillList == 728 and mobhp < 70 and mobhp >= 40)) then
        if mob:getLocalVar("nuclearWaste") == 0 then
            return 0
        end
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    mob:setLocalVar("nuclearWaste", 1)
    local typeEffect = tpz.effect.ELEMENTALRES_DOWN
    local resist = applyPlayerResistance(mob,typeEffect,target,mob:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT),0,0);
    if (resist >= 0.25) then
        target:addStatusEffectEx(typeEffect, 0, 50, 0, 60)
        skill:setMsg(tpz.msg.basic.NONE)
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end
    return typeEffect
end