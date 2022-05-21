-----------------------------------
-- Ying Era Module
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
-----------------------------------
local m = Module:new("era_ying")

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Ying.onMobSpawn", function(mob)
    local zone = mob:getZone()
    local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    xi.dynamis.setNMStats(mob)
    if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
        dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
        dynaLord:setMod(xi.mod.UDMGBREATH, -100)
        dynaLord:setLocalVar("magImmune", 0)
        mob:setSpawn(-364, -35.661, 17.254) -- Reset Ying's spawn point to initial spot.
    else
        mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
    end
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Ying.onMobFight", function(mob, target)
    local zone = mob:getZone()
    local ying = GetMobByID(zone:getLocalVar("Ying"))
    local yingToD = mob:getLocalVar("yingToD")
    -- Repop ying every 30 seconds if Ying is up and ying is not.
    if not ying:isSpawned() and os.time() > yingToD + 30 then
        ying:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        ying:spawn()
        ying:updateEnmity(target)
    end
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Ying.onMobRoam", function(mob) xi.dynamis.mobOnRoam(mob) end)
m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Ying.onMobRoamAction", function(mob) xi.dynamis.mobOnRoamAction(mob) end)

-- -----------------------------------
-- -- Area: Dynamis - Xarcabard
-- --  Mob: Animated Claymore
-- -----------------------------------
-- mixins = {require("scripts/mixins/families/animated_weapons")};
-- require("scripts/globals/dynamis")
-- require("scripts/globals/status")
-- local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-- -----------------------------------

-- local zone = 135

-- function onMobSpawn(mob)
--     require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
--     local mobID = mob:getID()
--     dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil)
--     dynamis.setAnimatedWeaponStats(mob)
-- end

-- function onMobEngaged(mob, target)
--     require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
--     randomChildrenListArg = nil
--     if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
--     dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
-- end

-- function onMonsterMagicPrepare(mob, target)
--     local warp = mob:getLocalVar("warp")
--     local rnd = math.random()
--     if warp == 1 then
--         return 261 -- warp
--     elseif rnd < 0.5 then
--         return 181 -- blizzaga iii
--     elseif not mob:hasStatusEffect(tpz.effect.ICE_SPIKES) and rnd < 0.75 then
--         return 250 -- ice spikes
--     else
--         return 273 -- sleepga
--     end
-- end

-- function onMobFight(mob, target)
-- end

-- function onMobRoamAction(mob)
--     dynamis.mobOnRoamAction(mob)
-- end

-- function onMobRoam(mob)
--     dynamis.mobOnRoam(mob)
-- end

-- function onMobDeath(mob, player, isKiller)
--     local instance = mob:getInstance()
--     DespawnMob(17330365, instance)
--     DespawnMob(17330366, instance)
--     DespawnMob(17330367, instance)
--     DespawnMob(17330372, instance)
--     DespawnMob(17330373, instance)
--     DespawnMob(17330374, instance)
-- end


return m