-----------------------------------
-- Area: Kazham
--  NPC: Nenepp
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

local path =
{
    29.014000, -11.00000, -183.884000,
    31.023000, -11.00000, -183.538000,
    33.091000, -11.00000, -183.738000
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrol(npc, path)
end


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
    local goodtrade = trade:hasItemQty(4600, 1)
    local badtrade = (trade:hasItemQty(483, 1) or trade:hasItemQty(22, 1) or trade:hasItemQty(1157, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(1008, 1) or trade:hasItemQty(905, 1) or trade:hasItemQty(4599, 1) or trade:hasItemQty(1147, 1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 9 or failed == 10 then
            if goodtrade then
                player:startEvent(241)
            elseif badtrade then
                player:startEvent(238)
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
            player:startEvent(206)
            npc:wait()
        elseif (progress == 9 or failed == 10) then
                player:startEvent(212)  -- asking for lucky egg
        elseif (progress >= 10 or failed >= 11) then
            player:startEvent(250) -- happy with lucky egg
        end
    else
        player:startEvent(206)
        npc:wait()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)

    if (csid == 241) then    -- correct trade, finished quest and receive opo opo crown and 3 pamamas
        local FreeSlots = player:getFreeSlotsCount()
        if (FreeSlots >= 4) then
            player:tradeComplete()
            player:addFame(KAZHAM, 75)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.THE_OPO_OPO_AND_I)
            player:addItem(13870)   -- opo opo crown
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13870)
            player:addItem(4468, 3)  -- 3 pamamas
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4468, 3)
            player:setCharVar("OPO_OPO_PROGRESS", 0)
            player:setCharVar("OPO_OPO_FAILED", 0)
            player:setCharVar("OPO_OPO_RETRY", 0)
            player:setTitle(tpz.title.KING_OF_THE_OPOOPOS)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        end
    elseif (csid == 238) then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED", 1)
        player:setCharVar("OPO_OPO_RETRY", 10)
    else
        npc:wait(0)
    end
end
