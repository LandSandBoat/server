-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'ghrah
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Set core Skin and mob elemental resist/weakness; other elements set to 0.
    -- Set to non aggro.
    mob:setAnimationSub(0)
    mob:setAggressive(false)
    mob:setLocalVar("roamTime", os.time())
    mob:setLocalVar("form2", math.random(1, 3))
    local skin = math.random(1161, 1168)
    mob:setModelId(skin)
    if (skin == 1161) then -- Fire
        mob:setMod(xi.mod.ICE_RES, 27)
        mob:setMod(xi.mod.WATER_RES, -27)
    elseif (skin == 1162) then --Ice
        mob:setMod(xi.mod.WIND_RES, 27)
        mob:setMod(xi.mod.FIRE_RES, -27)
    elseif (skin == 1163) then -- Wind
        mob:setMod(xi.mod.ICE_RES, -27)
        mob:setMod(xi.mod.EARTH_RES, 27)
    elseif (skin == 1164) then --Earth
        mob:setMod(xi.mod.THUNDER_RES, 27)
        mob:setMod(xi.mod.WIND_RES, -27)
    elseif (skin == 1165) then --Lightning
        mob:setMod(xi.mod.WATER_RES, 27)
        mob:setMod(xi.mod.EARTH_RES, -27)
    elseif (skin == 1166) then -- Water
        mob:setMod(xi.mod.THUNDER_RES, -27)
        mob:setMod(xi.mod.FIRE_RES, 27)
    elseif (skin == 1167) then --Light
        mob:setMod(xi.mod.LIGHT_RES, 27)
        mob:setMod(xi.mod.DARK_RES, -27)
    elseif (skin == 1168) then --Dark
        mob:setMod(xi.mod.DARK_RES, 27)
        mob:setMod(xi.mod.LIGHT_RES, -27)
    end
end

entity.onMobRoam = function(mob)
    local roamTime = mob:getLocalVar("roamTime")
    if (mob:getAnimationSub() == 0 and os.time() - roamTime > 60) then
        mob:setAnimationSub(mob:getLocalVar("form2"))
        mob:setLocalVar("roamTime", os.time())
        mob:setAggressive(true)
    elseif (mob:getAnimationSub() == mob:getLocalVar("form2") and os.time() - roamTime > 60) then
        mob:setAnimationSub(0)
        mob:setAggressive(false)
        mob:setLocalVar("roamTime", os.time())
    end
end

entity.onMobFight = function(mob, target)

    local changeTime = mob:getLocalVar("changeTime")

    if (mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60) then
        mob:setAnimationSub(mob:getLocalVar("form2"))
        mob:setAggressive(true)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    elseif (mob:getAnimationSub() == mob:getLocalVar("form2") and mob:getBattleTime() - changeTime > 60) then
        mob:setAnimationSub(0)
        mob:setAggressive(false)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
