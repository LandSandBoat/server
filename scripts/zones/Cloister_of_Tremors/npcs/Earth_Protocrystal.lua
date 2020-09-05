-----------------------------------
-- Area: Cloister of Tremors
-- NPC:  Earth Protocrystal
-- Involved in Quest: Trial by Earth
-- !pos -539 1 -493 209
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Tremors/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/bcnm")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(ASA) == tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE and player:getCharVar("ASA4_Amber") == 1) then
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
        player:delKeyItem(tpz.ki.DOMINAS_AMBER_SEAL)
        player:addKeyItem(tpz.ki.AMBER_COUNTERSEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AMBER_COUNTERSEAL)
        player:setCharVar("ASA4_Amber", "2")
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end

end
