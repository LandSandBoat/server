-----------------------------------
-- Area: The_Garden_of_RuHmet
-- NPC:  _0z0
-----------------------------------

require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/bcnm")

function onTrade(player, npc, trade)

    if (TradeBCNM(player, npc, trade)) then
        return
    end

end

function onTrigger(player, npc)
    --player:addMission(COP, tpz.mission.id.cop.WHEN_ANGELS_FALL)
    --player:setCharVar("PromathiaStatus", 3)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL and player:getCharVar("PromathiaStatus")==3) then
        player:startEvent(203)
    elseif (EventTriggerBCNM(player, npc)) then
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.WHEN_ANGELS_FALL and player:getCharVar("PromathiaStatus")==5) then
        player:startEvent(205)
    end
    return 1
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)
    if ( csid == 203) then
        player:setCharVar("PromathiaStatus", 4)
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end
end
