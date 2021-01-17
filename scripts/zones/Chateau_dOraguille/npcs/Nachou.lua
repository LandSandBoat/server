-----------------------------------
-- Area: Chateau d'Oraguille
--   NPC: Nachou
-- Type: Standard NPC
-- !pos -39.965 -3.999 34.292 233
-----------------------------------
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local missionStatus = player:getCharVar("MissionStatus")

    -- San d'Oria 9-2 "The Heir to the Light" (optional dialogues)
    if
        player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and
        (missionStatus == 2 or missionStatus == 5)
    then
        if missionStatus == 5 then
            player:startEvent(6)
        else
            player:startEvent(4)
        end

    -- Default dialogue
    else
        player:startEvent(523)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
