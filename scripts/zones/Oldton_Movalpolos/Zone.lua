-----------------------------------
--
-- Zone: Oldton_Movalpolos (11)
--
-----------------------------------
local ID = require("scripts/zones/Oldton_Movalpolos/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/treasure")
require("scripts/globals/helm")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())
    tpz.treasure.initZone(zone)
    tpz.helm.initZone(zone, tpz.helm.type.MINING)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local louverancePath = player:getCharVar("COP_Louverance_s_Path")
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(70.956, 5.99, 139.843, 134)
    end

    if player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and (louverancePath == 3 or louverancePath == 4) then
        cs = 1
    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") == 3 and player:getCharVar("Promathia_kill_day") < os.time() and player:getCharVar("COP_jabbos_story") == 0 then
        cs = 57
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:setCharVar("COP_Louverance_s_Path", 5)
    elseif csid == 57 then
        player:setCharVar("COP_jabbos_story", 1)
    end
end

return zone_object
