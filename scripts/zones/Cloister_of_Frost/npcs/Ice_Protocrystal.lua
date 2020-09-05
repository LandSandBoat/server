-----------------------------------
-- Area: Cloister of Frost
-- NPC:  Ice Protocrystal
-- Involved in Quests: Trial by Ice, Trial Size Trial by Ice
-- !pos 558 0 596 203
-----------------------------------

require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Cloister_of_Frost/IDs")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(ASA) == tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE and player:getCharVar("ASA4_Azure") == 1) then
        player:startEvent(2)
    elseif (EventTriggerBCNM(player, npc)) then
        return
    else
        player:messageSpecial(ID.text.PROTOCRYSTAL)
    end

end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    --printf("onFinish CSID: %u", csid)
    --printf("onFinish RESULT: %u", option)

    if (csid==2) then
        player:delKeyItem(tpz.ki.DOMINAS_AZURE_SEAL)
        player:addKeyItem(tpz.ki.AZURE_COUNTERSEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AZURE_COUNTERSEAL)
        player:setCharVar("ASA4_Azure", "2")
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end

end
