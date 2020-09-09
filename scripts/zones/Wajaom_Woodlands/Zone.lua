-----------------------------------
--
-- Zone: Wajaom_Woodlands (51)
--
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/chocobo_digging")
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/chocobo")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.HARVESTING)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        if player:getCurrentMission(TOAU) == tpz.mission.id.toau.UNRAVELING_REASON then
            player:setPos(-200.036, -10, 79.948, 254)
            cs = 11
        else
            player:setPos(610.542, -28.547, 356.247, 122)
        end
    elseif player:getCharVar("threemenandaclosetCS") == 2 and prevZone == tpz.zone.AHT_URHGAN_WHITEGATE then
        cs = 510
    elseif player:getCharVar("princeandhopper") == 1 then
        cs = 513
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    -- printf("Update CSID: %u", csid)
    -- printf("Update RESULT: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("Finish CSID: %u", csid)
    -- printf("Finish RESULT: %u", option)
    if csid == 510 then
        player:setCharVar("threemenandaclosetCS", 3)
    elseif csid == 11 then
        player:startEvent(21)
    elseif csid == 21 then
        player:startEvent(22)
    elseif csid == 22 then
        player:completeMission(TOAU, tpz.mission.id.toau.UNRAVELING_REASON)
        player:setTitle(tpz.title.ENDYMION_PARATROOPER)
        player:setCharVar("TOAUM40_STARTDAY", 0)
        player:addMission(TOAU, tpz.mission.id.toau.LIGHT_OF_JUDGMENT)
    elseif csid == 513 then
        player:setCharVar("princeandhopper", 2)
    end
end
