-----------------------------------
-- Area: Giddeus
--  NPC: Uu Zhoumo
-- Involved in Mission 2-3
-- !pos -179 16 155 145
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_EMISSARY_WINDURST and trade:hasItemQty(16509, 1) and trade:getItemCount() == 1) then -- Trade Aspir Knife
        player:startEvent(41)
    end

end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.SHIELD_OFFERING)) then
        player:startEvent(42)
    elseif (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_EMISSARY_WINDURST) then
        if (player:hasKeyItem(tpz.ki.DULL_SWORD)) then
            player:startEvent(40)
        elseif (player:getCharVar("MissionStatus") == 5) then
            player:startEvent(43)
        else
            player:startEvent(44)
        end
    else
        player:startEvent(44)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 40) then
        player:setCharVar("MissionStatus", 5)
        player:delKeyItem(tpz.ki.DULL_SWORD)
    elseif (csid == 41) then
        player:tradeComplete()
        player:setCharVar("MissionStatus", 6)
    elseif (csid == 42) then
        player:setCharVar("MissionStatus", 6)
        player:delKeyItem(tpz.ki.SHIELD_OFFERING)
    end
end
