-----------------------------------
-- Yang Era Module
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
-----------------------------------
local m = Module:new("era_Yang")

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Yang.onMobSpawn", function(mob)
    local zone = mob:getZone()
    local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    xi.dynamis.setNMStats(mob)
    if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
        dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
        dynaLord:setMod(xi.mod.UDMGBREATH, -100)
        dynaLord:setLocalVar("magImmune", 0)
        mob:setSpawn(-364, -35.661, 17.254) -- Reset Yang's spawn point to initial spot.
    else
        mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
    end
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Yang.onMobFight", function(mob, target)
    local zone = mob:getZone()
    local Yang = GetMobByID(zone:getLocalVar("Yang"))
    local YangToD = mob:getLocalVar("YangToD")
    -- Repop Yang every 30 seconds if Yang is up and Yang is not.
    if not Yang:isSpawned() and os.time() > YangToD + 30 then
        Yang:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        Yang:spawn()
        Yang:updateEnmity(target)
    end
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Yang.onMobRoam", function(mob) xi.dynamis.mobOnRoam(mob) end)
m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Yang.onMobRoamAction", function(mob) xi.dynamis.mobOnRoamAction(mob) end)

return m