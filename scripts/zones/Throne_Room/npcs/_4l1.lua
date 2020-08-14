-----------------------------------
-- Area: Throne Room
-- NPC:  Throne Room
-- Type: Door
-- !pos -111 -6 0 165
-------------------------------------

require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
require("scripts/globals/missions")

    -- events:
    -- 7D00 : BC menu
    -- Param 4 is a bitmask for the choice of battlefields in the menu:

    -- 0: Mission 5-2
    -- 1:
    -- 2:
    -- 3:
    -- 4:
    -- 5:

    -- Param 8 is a flag: 0 : menu, >0 : automatically enter and exit

    -- 7D01 : final BC event.
    -- param 2: #time record for this mission
    -- param 3: #clear time in seconds
    -- param 6: #which mission (linear numbering as above)
    -- 7D03 : stay/run away

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(player:getNation()) == tpz.mission.id.nation.SHADOW_LORD and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(6)
    elseif (EventTriggerBCNM(player, npc)) then
        return 1
    end

end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 6) then
        player:setCharVar("MissionStatus", 3)
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end

end
