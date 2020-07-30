-----------------------------------
--
-- Zone: Mhaura (249)
--
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------

function onGameHour(zone)
    -- Script for Laughing Bison sign flip animations
    local timer = 1152 - ((os.time() - 1009810802)%1152)

    -- Next ferry is Al Zhabi for higher values.
    if timer >= 576 then
        GetNPCByID(ID.npc.LAUGHING_BISON):AnimationSub(1)
    else
        GetNPCByID(ID.npc.LAUGHING_BISON):AnimationSub(0)
    end
    SetServerVariable("Mhaura_Deastination", math.random(1, 100))
end

function onInitialize(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
end

function onZoneIn(player, prevZone)
    local cs = -1
    local currentday = tonumber(os.date("%j"))

    if player:getCurrentMission(ROV) == tpz.mission.id.rov.RESONACE and player:getCharVar("RhapsodiesStatus") == 0 then
        cs = 368
    end

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        if prevZone == tpz.zone.SHIP_BOUND_FOR_MHAURA or prevZone == tpz.zone.OPEN_SEA_ROUTE_TO_MHAURA or prevZone == tpz.zone.SHIP_BOUND_FOR_MHAURA_PIRATES then
            cs = 202
            player:setPos(14.960, -3.430, 18.423, 192)
        else
            player:setPos(0.003, -6.252, 117.971, 65)
        end
    end

    if player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus")==3 and player:getCharVar("Promathia_kill_day") ~= currentday and player:getCharVar("COP_shikarees_story")== 0 then
        cs = 322
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onTransportEvent(player, transport)
    if transport == 47 or transport == 46 then
        if not player:hasKeyItem(tpz.ki.BOARDING_PERMIT) or ENABLE_TOAU == 0 then
            player:setPos(8.200, -1.363, 3.445, 192)
            player:messageSpecial(ID.text.DO_NOT_POSSESS, tpz.ki.BOARDING_PERMIT)
        else
            player:startEvent(200)
        end
    else
        player:startEvent(200)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 200 then
        local DepartureTime = VanadielHour()
        if DepartureTime % 8 == 0 then
            if GetServerVariable("Mhaura_Deastination") > 89 then
                player:setPos(0, 0, 0, 0, tpz.zone.SHIP_BOUND_FOR_SELBINA_PIRATES)
            else
                player:setPos(0, 0, 0, 0, tpz.zone.SHIP_BOUND_FOR_SELBINA)
            end
        elseif DepartureTime % 8 == 4 then
            player:setPos(0, 0, 0, 0, tpz.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI)
        else
            player:setPos(8, -1, 5, 62, 249) -- Something went wrong, dump them on the dock for safety.
        end
    elseif csid == 322 then
        player:setCharVar("COP_shikarees_story", 1)
    elseif csid == 368 then
        -- Flag ROV 1-3 Mhuara Route (2)
        player:setCharVar("RhapsodiesStatus", 2)
        player:completeMission(ROV, tpz.mission.id.rov.RESONACE)
        player:addMission(ROV, tpz.mission.id.rov.EMISSARY_FROM_THE_SEAS)
    end
end
