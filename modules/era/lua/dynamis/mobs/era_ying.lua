-----------------------------------
-- Yang Era Module
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
-----------------------------------
local m = Module:new("era_yang")

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
    local yang = GetMobByID(zone:getLocalVar("Yang"))
    local yangToD = mob:getLocalVar("yangToD")
    -- Repop Yang every 30 seconds if Ying is up and Yang is not.
    if not yang:isSpawned() and os.time() > yangToD + 30 then
        yang:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        yang:spawn()
        yang:updateEnmity(target)
    end
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Ying.onMobRoam", function(mob) xi.dynamis.mobOnRoam(mob) end)
m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Ying.onMobRoamAction", function(mob) xi.dynamis.mobOnRoamAction(mob) end)

return m