-----------------------------------
--
-- Zone: Bastok_Mines (234)
--
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)

    applyHalloweenNpcCostumes(zone:getID())
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if OPENING_CUTSCENE_ENABLE == 1 then
            cs = 1
        end
        player:setPos(-45, -0, 26, 213)
        player:setHomePoint()
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        position = math.random(1, 5) - 75
        player:setPos(116, 0.99, position, 127)
        if player:getMainJob() ~= player:getCharVar("PlayerMainJob") and player:getGMLevel() == 0 then
            cs = 30004
        end
        player:setCharVar("PlayerMainJob", 0)
    end

    -- ENTER THE TALEKEEPER
    if prevZone == tpz.zone.ZERUHN_MINES and player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.ENTER_THE_TALEKEEPER and player:getCharVar("MissionStatus") == 5 then
        cs = 176
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 1 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536) -- adventurer coupon
    elseif csid == 30004 and option == 0 then
        player:setHomePoint()
        player:messageSpecial(ID.text.HOMEPOINT_SET)
    elseif csid == 176 then
        finishMissionTimeline(player, 1, csid, option)
    end
end
