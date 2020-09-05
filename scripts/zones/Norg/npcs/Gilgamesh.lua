-----------------------------------
-- Area: Norg
--  NPC: Gilgamesh
-- !pos 122.452 -9.009 -12.052 252
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_PIRATE_S_COVE and player:getCharVar("MissionStatus") == 2) then
        if (trade:hasItemQty(1160, 1) and trade:getItemCount() == 1) then -- Frag Rock
            player:startEvent(99) -- Bastok Mission 6-2
        end
    end

end

function onTrigger(player, npc)

    local ZilartMission = player:getCurrentMission(ZILART)

    if (ZilartMission == tpz.mission.id.zilart.KAZAMS_CHIEFTAINESS) then
        player:startEvent(7)
    elseif (ZilartMission == tpz.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH) then
        player:startEvent(8)
    elseif (ZilartMission == tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE) then
        player:startEvent(9)
    elseif (ZilartMission == tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER) then
        player:startEvent(13)
    elseif (ZilartMission == tpz.mission.id.zilart.ROMAEVE) then
        player:startEvent(11)
    elseif (ZilartMission == tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL) then
        player:startEvent(170)
    elseif (ZilartMission == tpz.mission.id.zilart.ARK_ANGELS) then
        player:startEvent(171)
    elseif (ZilartMission == tpz.mission.id.zilart.THE_CELESTIAL_NEXUS) then
        player:startEvent(173)
    elseif (ZilartMission == tpz.mission.id.zilart.AWAKENING) then
        player:startEvent(177)
    end

end

--175  0  2  3  4  7  8  9  10  98  99  29  12
--13  146  158  164  169  170  171  172  173  176  177  232  233
--234
-- 98  99 mission bastok
-- 12 parle de kuzotz ? parle de bijoux aussi
-- 10 parle de zitah
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 99) then
        player:tradeComplete()
        player:setCharVar("MissionStatus", 3)
    end

end
