require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

g_mixins = g_mixins or {}

g_mixins.families.ghrah = function(ghrahMob)
    ghrahMob:addListener("SPAWN", "GHRAH_SPAWN", function(mob)
        mob:setAnimationSub(0)
        mob:setAggressive(false)
        mob:setLocalVar("roamTime", os.time())
        mob:setLocalVar("form2", math.random(1, 3))
        local skin = math.random(1161, 1168)
        mob:setModelId(skin)

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
            mob:setMod(xi.mod.WIND_RES, -27)
        elseif skin == 1165 then -- Lightning
            mob:setSpellList(482)
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
    end)

    ghrahMob:addListener("ROAM_TICK", "GHRAH_TICK", function(mob)
        local roamTime = mob:getLocalVar("roamTime")
        if
            mob:getAnimationSub() == 0 and
            os.time() - roamTime > 60
        then
            mob:setAnimationSub(mob:getLocalVar("form2"))
            mob:setLocalVar("roamTime", os.time())
            mob:setAggressive(true)

            if mob:getAnimationSub() == 2 then
                mob:addMod(xi.mod.ATTP, 50) -- spider form att+
            end
        elseif
            mob:getAnimationSub() == mob:getLocalVar("form2") and
            os.time() - roamTime > 60
        then
            mob:setAnimationSub(0)
            mob:setAggressive(false)
            mob:setLocalVar("roamTime", os.time())
            mob:delMod(xi.mod.ATTP, 50)
        end
    end)

    ghrahMob:addListener("COMBAT_TICK", "GHRAH_COMBAT", function(mob)
        local changeTime = mob:getLocalVar("changeTime")

        if mob:getXPos() > 0 then
            mob:setLocalVar("form2", 2)
        else
            mob:setLocalVar("form2", 3)
        end

        if
            mob:getAnimationSub() == 0 and
            mob:getBattleTime() - changeTime > 60
        then
            mob:setAnimationSub(mob:getLocalVar("form2"))
            mob:setAggressive(true)
            mob:setLocalVar("changeTime", mob:getBattleTime())

            if mob:getAnimationSub() == 2 then
                mob:addMod(xi.mod.ATTP, 50) -- spider form att+
            end
        elseif
            mob:getAnimationSub() == mob:getLocalVar("form2") and
            mob:getBattleTime() - changeTime > 60
        then
            mob:setAnimationSub(0)
            mob:setAggressive(false)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            mob:delMod(xi.mod.ATTP, 50)
        end
    end)
end

return g_mixins.families.ghrah
