-----------------------------------
-- Area: Sacrificial Chamber
-- NPC:  Mahogany Door
-- !pos 299 0.1 349 163
-------------------------------------

require("scripts/globals/bcnm")
require("scripts/globals/missions")
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    if (EventTriggerBCNM(player, npc)) then
        return 1
    else
        player:messageSpecial(ID.text.DOOR_SHUT)
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
