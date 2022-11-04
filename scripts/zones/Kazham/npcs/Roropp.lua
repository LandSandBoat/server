-----------------------------------
-- Area: Kazham
--  NPC: Roropp
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 17.314, y = -8.000, z = -110.064, wait = 5000 },
    { x = 13.323, z = -102.821, wait = 5000 },
    { x = 17.314, z = -110.064, wait = 5000 },
    { x = 12.576, z = -113.211, wait = 5000 },
    { x = 17.314, z = -110.064, wait = 5000 },
    { x = 13.323, z = -102.821, wait = 5000 },
    { x = 17.388, z = -99.219, wait = 5000 },
    { x = 15.511, z = -112.292, wait = 5000 },
    { x = 13.605, z = -109.863, wait = 5000 },
    { x = 15.511, z = -112.292, wait = 5000 },
    { x = 13.605, z = -109.863, wait = 5000 },
    { x = 17.388, z = -99.219, wait = 5000 },
    { x = 13.323, z = -102.821, wait = 5000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
end

entity.onTrade = function(player, npc, trade)
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
    local opoOpoAndIStatus = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar("OPO_OPO_PROGRESS")
    local failed = player:getCharVar("OPO_OPO_FAILED")
    local goodtrade = trade:hasItemQty(1157, 1)
    local badtrade = trade:hasItemQty(483, 1) or trade:hasItemQty(22, 1) or trade:hasItemQty(1008, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(4599, 1) or trade:hasItemQty(905, 1) or trade:hasItemQty(1147, 1) or trade:hasItemQty(4600, 1)

    if opoOpoAndIStatus == QUEST_ACCEPTED then
        if progress == 3 or failed == 4 then
            if goodtrade then
                player:startEvent(222)
            elseif badtrade then
                player:startEvent(232)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local opoOpoAndIStatus = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar("OPO_OPO_PROGRESS")
    local failed = player:getCharVar("OPO_OPO_FAILED")
    local retry = player:getCharVar("OPO_OPO_RETRY")

    if opoOpoAndIStatus == QUEST_ACCEPTED then
        if retry >= 1 then                          -- has failed on future npc so disregard previous successful trade
            player:startEvent(200)
        elseif progress == 3 or failed == 4 then
            player:startEvent(210)  -- asking for sands of silence
        elseif progress >= 4 or failed >= 5 then
            player:startEvent(245) -- happy with sands of silence
        end
    else
        player:startEvent(200)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 222 then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 3 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS", 4)
            player:setCharVar("OPO_OPO_FAILED", 0)
        else
            player:setCharVar("OPO_OPO_FAILED", 5)
        end
    elseif csid == 232 then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED", 1)
        player:setCharVar("OPO_OPO_RETRY", 4)
    end
end

return entity
