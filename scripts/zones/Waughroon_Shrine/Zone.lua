-----------------------------------
--
-- Zone: Waughroon_Shrine (144)
--
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/conquest")
require("scripts/globals/quests")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-361.434, 101.798, -259.996, 0)
    end
    if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.A_THIEF_IN_NORG) == QUEST_ACCEPTED and player:getCharVar("aThiefinNorgCS") == 4) then
        cs = 2
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

    if (csid == 2) then
        player:setCharVar("aThiefinNorgCS", 5)
    end

end
