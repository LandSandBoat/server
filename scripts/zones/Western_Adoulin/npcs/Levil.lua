-----------------------------------
-- Area: Western Adoulin (256)
--  NPC: Levil
-- Type: Quest and SoA Missions NPC
-- !pos -87.204 3.350 12.655
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local arceliaAppears = player:getCurrentMission(SOA) == tpz.mission.id.soa.ARCIELA_APPEARS_AGAIN

    if arceliaAppears and player:getFameLevel(ADOULIN) >= 4 then
        if player:getCharVar("SOA") == 0 then
            player:startEvent(6)
        else
            player:startEvent(7)
        end
    else
        player:startEvent(40)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 6 or csid == 7) and option == 1 then
        player:setCharVar("SOA", 0)
        player:completeMission(SOA, tpz.mission.id.soa.ARCIELA_APPEARS_AGAIN)
        player:addMission(SOA, tpz.mission.id.soa.BUILDING_PROSPECTS)
    elseif csid == 6 and option == 0 then
        player:setCharVar("SOA", 1)
    end
end
