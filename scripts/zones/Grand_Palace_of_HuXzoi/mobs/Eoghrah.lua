-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  Mob: Eo'ghrah
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    -- Set core Skin and mob elemental resist/weakness; other elements set to 0.
    -- Set to non aggro.
    mob:setAnimationSub(0)
    mob:setAggressive(false)
    mob:setLocalVar("roamTime", os.time())
    mob:setLocalVar("form2", math.random(2, 3))
    local skin = math.random(1161, 1168)
    mob:setModelId(skin)
    if (skin == 1161) then -- Fire
        mob:setMod(tpz.mod.ICERES, 27)
        mob:setMod(tpz.mod.WATERRES, -27)
    elseif (skin == 1164) then --Earth
        mob:setMod(tpz.mod.THUNDERRES, 27)
        mob:setMod(tpz.mod.WINDRES, -27)
    elseif (skin == 1162) then -- Water
        mob:setMod(tpz.mod.THUNDERRES, -27)
        mob:setMod(tpz.mod.FIRERES, 27)
    elseif (skin == 1163) then -- Wind
        mob:setMod(tpz.mod.ICERES, -27)
        mob:setMod(tpz.mod.EARTHRES, 27)
    elseif (skin == 1166) then --Ice
        mob:setMod(tpz.mod.WINDRES, 27)
        mob:setMod(tpz.mod.FIRERES, -27)
    elseif (skin == 1165) then --Lightning
        mob:setMod(tpz.mod.WATERRES, 27)
        mob:setMod(tpz.mod.EARTHRES, -27)
    elseif (skin == 1167) then --Light
        mob:setMod(tpz.mod.LIGHTRES, 27)
        mob:setMod(tpz.mod.DARKRES, -27)
    elseif (skin == 1168) then --Dark
        mob:setMod(tpz.mod.DARKRES, 27)
        mob:setMod(tpz.mod.LIGHTRES, -27)
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

function onMobDeath(mob, player, isKiller)
end

return entity
