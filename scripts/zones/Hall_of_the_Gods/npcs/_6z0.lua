-----------------------------------
-- Area: Hall of the Gods
--  NPC: Cermet Gate
-- Gives qualified players access to Ru'Aun Gardens.
-- !pos 0 -12 48 251
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.CERULEAN_CRYSTAL) then
        player:startEvent(1)
    else
        if player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL then
            player:startEvent(4) -- Zilart CS.
        else
            player:startEvent(2)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 1 and player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_TEMPLE_OF_DESOLATION then
        player:addTitle(tpz.title.SEALER_OF_THE_PORTAL_OF_THE_GODS)
        player:completeMission(ZILART, tpz.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)
        player:addMission(ZILART, tpz.mission.id.zilart.THE_HALL_OF_THE_GODS)
    elseif csid == 4 then
        player:setCharVar("ZilartStatus", 0)
        player:completeMission(ZILART, tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)
        player:addMission(ZILART, tpz.mission.id.zilart.THE_GATE_OF_THE_GODS)
    end
end
