-----------------------------------
-- Area: Misareaux Coast
--  NPC: Iron Gate
--  Entrance to Sacrarium
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local currentCoP = player:getCurrentMission(COP)
    local PromathiaStatus = player:getCharVar("PromathiaStatus")

    if (currentCoP == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and PromathiaStatus == 1) then
        player:startEvent(9)
    elseif (player:hasCompletedMission(COP, tpz.mission.id.cop.THE_LAST_VERSE) or (currentCoP == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and PromathiaStatus >= 2)or(currentCoP > tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP)) then
        player:startEvent(502)
    else
        player:messageSpecial(ID.text.DOOR_CLOSED)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 9 and option == 1) then
        player:setCharVar("PromathiaStatus", 2)
        player:setPos(-220.075, -15.999, 79.634, 62, 28) -- To Sacrarium {R}
    elseif (csid == 502 and option == 1) then
        player:setPos(-220.075, -15.999, 79.634, 62, 28) -- To Sacrarium {R}
    end

end
