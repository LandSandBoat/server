-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("twoHourPer", 50)
    mob:setLocalVar("canTwoHour", 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    mob:setAnimationSub(0)
    mob:setAggressive(false)
    mob:setLocalVar("roamTime", os.time())
    mob:setLocalVar("form2", math.random(1, 3))
    local skin = math.random(1161, 1168)

    if skin == 1161 then -- Fire
        mob:setSpellList(484)
        mob:setMod(xi.mod.ICE_RES, 80)
        mob:setMod(xi.mod.PARALYZERES, 99)
        mob:setMod(xi.mod.BINDRES, 99)
        mob:setMod(xi.mod.FIRE_RES, 100)
        mob:setMod(xi.mod.WATER_RES, -27)
    elseif skin == 1162 then -- Ice
        mob:setSpellList(479)
        mob:setMod(xi.mod.WIND_RES, 80)
        mob:setMod(xi.mod.GRAVITYRES, 99)
        mob:setMod(xi.mod.SILENCERES, 99)
        mob:setMod(xi.mod.ICE_RES, 100)
        mob:setMod(xi.mod.PARALYZERES, 100)
        mob:setMod(xi.mod.BINDRES, 100)
        mob:setMod(xi.mod.FIRE_RES, -27)
    elseif skin == 1163 then -- Wind
        mob:setSpellList(480)
        mob:setMod(xi.mod.EARTH_RES, 80)
        mob:setMod(xi.mod.SLOWRES, 99)
        mob:setMod(xi.mod.WIND_RES, 100)
        mob:setMod(xi.mod.GRAVITYRES, 100)
        mob:setMod(xi.mod.SILENCERES, 100)
        mob:setMod(xi.mod.ICE_RES, -27)
    elseif skin == 1164 then -- Earth
        mob:setSpellList(481)
        mob:setMod(xi.mod.THUNDER_RES, 80)
        mob:setMod(xi.mod.STUNRES, 99)
        mob:setMod(xi.mod.EARTH_RES, 100)
        mob:setMod(xi.mod.SLOWRES, 100)
        mob:setMod(xi.mod.WINDRES, -27)
    elseif skin == 1165 then -- Lightning
        mob:setSpellList(474)
        mob:setMod(xi.mod.WATER_RES, 80)
        mob:setMod(xi.mod.POISONRES, 99)
        mob:setMod(xi.mod.THUNDER_RES, 100)
        mob:setMod(xi.mod.STUNRES, 100)
        mob:setMod(xi.mod.EARTH_RES, -27)
    elseif skin == 1166 then -- Water
        mob:setSpellList(483)
        mob:setMod(xi.mod.FIRE_RES, 80)
        mob:setMod(xi.mod.WATER_RES, 100)
        mob:setMod(xi.mod.POISONRES, 100)
        mob:setMod(xi.mod.THUNDER_RES, -27)
    elseif skin == 1167 then -- Light
        mob:setSpellList(478)
        mob:setMod(xi.mod.LIGHT_RES, 100)
        mob:setMod(xi.mod.LULLABYRES, 100)
        mob:setMod(xi.mod.DARK_RES, -27)
    elseif skin == 1168 then -- Dark
        mob:setSpellList(477)
        mob:setMod(xi.mod.DARK_RES, 100)
        mob:setMod(xi.mod.SLEEPRES, 100)
        mob:setMod(xi.mod.LIGHT_RES, -27)
    end
    mob:setModelId(1167)
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar("changeTime")
    local state = mob:getLocalVar("state")
    local twoHourPer = mob:getLocalVar("twoHourPer")
    if mob:getBattleTime() - changeTime > 30 then
        mob:setLocalVar("state", math.random(0, 3))
        mob:setAnimationSub(state)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end

    if
        mob:getLocalVar("canTwoHour") == 0 and
        mob:getHPP() < twoHourPer
    then
        if mob:getLocalVar("state") == 1 then
            mob:useMobAbility(694) --invincible
        elseif mob:getLocalVar("state") == 2 then
            mob:useMobAbility(688) -- mighty strikes
        elseif mob:getLocalVar("state") == 0 then
            mob:useMobAbility(691) -- manafont
            local skin = mob:getLocalVar("skin")
            if skin == 1161 then -- Fire
                mob:setSpellList(476)
            elseif skin == 1162 then --Earth
                mob:setSpellList(473)
            elseif skin == 1163 then -- Water
                mob:setSpellList(475)
            elseif skin == 1164 then -- Wind
                mob:setSpellList(472)
            elseif skin == 1165 then --Ice
                mob:setSpellList(479)
            elseif skin == 1166 then --Lightning
                mob:setSpellList(482)
            elseif skin == 1167 then --Light
                mob:setSpellList(470)
            elseif skin == 1168 then --Dark
                mob:setSpellList(469)
            end
            mob:setLocalVar("delay", mob:getBattleTime())
            mob:setMobMod(xi.mobMod.MAGIC_COOL, 0)
        elseif mob:getLocalVar("state") == 3 then
            mob:useMobAbility(693) -- perfect dodge
        end
        mob:setLocalVar("canTwoHour", 1)
    end

    if
        not mob:hasStatusEffect(xi.effect.MANAFONT) and --Changing spell list back after manafont is over
        mob:getLocalVar("canTwoHour") == 1 and
        mob:getBattleTime() - mob:getLocalVar("delay") > 15 and
        mob:getLocalVar("state2") == 0
    then
        local skin = mob:getLocalVar("skin")
        if skin == 1161 then -- Fire
            mob:setSpellList(484)
        elseif skin == 1162 then --Earth
            mob:setSpellList(481)
        elseif skin == 1163 then -- Water
            mob:setSpellList(483)
        elseif skin == 1164 then -- Wind
            mob:setSpellList(480)
        elseif skin == 1165 then --Ice
            mob:setSpellList(479)
        elseif skin == 1166 then --Lightning
            mob:setSpellList(482)
        elseif skin == 1167 then --Light
            mob:setSpellList(478)
        elseif skin == 1168 then --Dark
            mob:setSpellList(477)
        end
        mob:setLocalVar("state2", 1)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    end
end

entity.onMobDeath  = function(mob, player, isKiller)
    -- if (player:getCurrentMission(COP) == xi.mission.id.cop.A_FATE_DECIDED  and player:getCharVar("PromathiaStatus")==1) then
    --     player:setCharVar("PromathiaStatus", 2)
    -- end
end

return entity
