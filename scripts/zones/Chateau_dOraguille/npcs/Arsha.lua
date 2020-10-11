-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Arsha
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    -- This NPC is relevant only to San d'Orians on missions
    if player:getNation() ~= tpz.nation.SANDORIA then
        player:startEvent(513)

    else
        local missions = tpz.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getCharVar("MissionStatus")

        -- San d'Oria 5-2 "The Shadow Lord" (optional)
        if
            -- Directly after winning BCNM and up until next mission
            -- Issue #1311 suggests the former only. Guides read like the latter. Let's keep both for now.
            (currentMission == missions.THE_SHADOW_LORD and MissionStatus == 5) or
            (player:hasCompletedMission(SANDORIA, missions.THE_SHADOW_LORD) and player:getRank() == 6 and
            (currentMission ~= missions.LEAUTE_S_LAST_WISHES or currentMission ~= missions.RANPERRE_S_FINAL_REST))
        then
            player:startEvent(85)
        else
            player:startEvent(513)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
