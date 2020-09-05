-----------------------------------
-- Area: Kazham
--  NPC: Kakapp
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
    -- item IDs
    -- 483       Broken Mithran Fishing Rod
    -- 22        Workbench
    -- 1008      Ten of Coins
    -- 1157      Sands of Silence
    -- 1158      Wandering Bulb
    -- 904       Giant Fish Bones
    -- 4599      Blackened Toad
    -- 905       Wyvern Skull
    -- 1147      Ancient Salt
    -- 4600      Lucky Egg
    local OpoOpoAndIStatus = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar("OPO_OPO_PROGRESS")
    local failed = player:getCharVar("OPO_OPO_FAILED")
    local goodtrade = trade:hasItemQty(905, 1)
    local badtrade = (trade:hasItemQty(483, 1) or trade:hasItemQty(22, 1) or trade:hasItemQty(1008, 1) or trade:hasItemQty(1157, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(4599, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(1147, 1) or trade:hasItemQty(4600, 1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 7 or failed == 8 then
            if goodtrade then
                player:startEvent(226)
            elseif badtrade then
                player:startEvent(236)
            end
        end
    end
end

function onTrigger(player, npc)
    local OpoOpoAndIStatus = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar("OPO_OPO_PROGRESS")
    local failed = player:getCharVar("OPO_OPO_FAILED")
    local retry = player:getCharVar("OPO_OPO_RETRY")

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if retry >= 1 then                          -- has failed on future npc so disregard previous successful trade
            player:startEvent(204)
        elseif (progress == 7 or failed == 8) then
                player:startEvent(213)  -- asking for wyvern skull
        elseif (progress >= 8 or failed >= 9) then
            player:startEvent(249) -- happy with wyvern skull
        end
    else
        player:startEvent(204)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 226) then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 7 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS", 8)
            player:setCharVar("OPO_OPO_FAILED", 0)
        else
            player:setCharVar("OPO_OPO_FAILED", 9)
        end
    elseif (csid == 236) then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED", 1)
        player:setCharVar("OPO_OPO_RETRY", 8)
    end
end
