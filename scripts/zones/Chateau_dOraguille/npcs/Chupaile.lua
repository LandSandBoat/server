-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Chupaile
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    -- This NPC is relevant only to San d'Orians on missions
    if player:getNation() ~= tpz.nation.SANDORIA then
        player:startEvent(514)

    else
        local sandyMissions = tpz.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getCharVar("MissionStatus")

        -- San d'Oria 5-2 "The Shadow Lord" (optional)
        if
            -- Directly after winning BCNM and up until next mission
            -- Issue #1311 suggests the former only. Guides read like the latter. Let's keep both for now.
            (currentMission == sandyMissions.THE_SHADOW_LORD and missionStatus == 5) or
            (player:hasCompletedMission(SANDORIA, sandyMissions.THE_SHADOW_LORD) and player:getRank() == 6 and
            (currentMission ~= sandyMissions.LEAUTE_S_LAST_WISHES or currentMission ~= sandyMissions.RANPERRE_S_FINAL_REST))
        then
            player:startEvent(86)
        else
            player:startEvent(514)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
