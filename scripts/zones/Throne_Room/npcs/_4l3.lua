-----------------------------------
-- Area: Throne Room
-- NPC:  Ore Door
-------------------------------------

require("scripts/globals/bcnm")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    if (EventTriggerBCNM(player, npc)) then
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

    if (EventFinishBCNM(player, csid, option)) then
        return
    end

end
