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
        local sandyMissions = tpz.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getCharVar("MissionStatus")

        -- San d'Oria 5-2 "The Shadow Lord" (optional)
        -- Only after speaking to Halver and obtaining Rank 6 and before entering the Great Hall
        if currentMission == sandyMissions.THE_SHADOW_LORD and missionStatus == 5 then
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
