-----------------------------------
-- Area: Port Jeuno
--  NPC: Horst
-- Type: Abyssea Warp NPC
-- !pos -54.379 0.001 -10.061 246
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local CRUOR = player:getCurrency("cruor")
    if (player:getQuestStatus(ABYSSEA, tpz.quest.id.abyssea.THE_TRUTH_BECKONS) == QUEST_ACCEPTED) then
        player:startEvent(339, 1, CRUOR, 7, 7, 7) -- Temp activated all locations till param handling sorted out.
    elseif (player:getQuestStatus(ABYSSEA, tpz.quest.id.abyssea.THE_TRUTH_BECKONS) == QUEST_COMPLETED) then
        player:startEvent(339, 2, CRUOR, 7, 7, 7) -- Temp activated all locations till param handling sorted out.
    else
        player:startEvent(339, 0)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local CRUOR = player:getCurrency("cruor")
    if (csid == 339) then
        if (option == 260) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(-562, 0.001, 640, 26, 102) -- La Theine Plateau
            end
        elseif (option == 264) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(91, -68, -582, 237, 108) -- Konshtat Highlands
            end
        elseif (option == 268) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(-28, 46, -680, 76, 117) -- Tahrongi Canyon
            end
        elseif (option == 272) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(241, 0.001, 11, 42, 104) -- Jugner Forest
            end
        elseif (option == 276) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(362, 0.001, -119, 4, 103) -- Valkrum
            end
        elseif (option == 280) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(-338, -23, 47, 167, 118) -- Buburimu Peninsula
            end
        elseif (option == 288) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(269, -7, -75, 192, 112) -- Xarcabard
            end
        elseif (option == 284) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(337, 0.001, -675, 52, 107)  -- South Gustaberg
            end
        elseif (option == 292) then
            if (CRUOR >= 200) then
                player:delCurrency("cruor", 200)
                player:setPos(-71, 0.001, 601, 126, 106) -- North Gustaberg
            end
        end
    end
end
