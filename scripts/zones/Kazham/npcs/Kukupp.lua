-----------------------------------
-- Area: Kazham
--  NPC: Kukupp
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = 44.089, y = -11.000, z = -178.976, wait = 5000 },
    { x = 40.132, y = -11.000, z = -179.322, wait = 5000 },
    { x = 44.089, y = -11.000, z = -178.976, wait = 5000 },
    { x = 40.132, y = -11.000, z = -176.322, wait = 5000 },
    { x = 46.417, y = -11.000, z = -176.672, wait = 5000 },
    { x = 40.132, y = -11.000, z = -176.322, wait = 5000 },
    { x = 46.417, y = -11.000, z = -176.672, wait = 5000 },
    { x = 40.132, y = -11.000, z = -176.322, wait = 5000 },
    { x = 46.417, y = -11.000, z = -176.672, wait = 5000 },
    { x = 40.132, y = -11.000, z = -176.322, wait = 5000 },
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
    local goodtrade = trade:hasItemQty(22, 1)
    local badtrade = trade:hasItemQty(483, 1) or trade:hasItemQty(1008, 1) or trade:hasItemQty(1157, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(4599, 1) or trade:hasItemQty(905, 1) or trade:hasItemQty(1147, 1) or trade:hasItemQty(4600, 1)

    if opoOpoAndIStatus == QUEST_ACCEPTED then
        if progress == 1 or failed == 2 then
            if goodtrade then
                player:startEvent(220)
            elseif badtrade then
                player:startEvent(230)
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
            player:startEvent(198)
        elseif progress == 1 or failed == 2 then
            player:startEvent(208)  -- asking for workbench
        elseif progress >= 2 or failed >= 3 then
            player:startEvent(243) -- happy with workbench
        end
    else
        player:startEvent(198)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 220 then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 1 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS", 2)
            player:setCharVar("OPO_OPO_FAILED", 0)
        else
            player:setCharVar("OPO_OPO_FAILED", 3)
        end
    elseif csid == 230 then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED", 1)
        player:setCharVar("OPO_OPO_RETRY", 2)
    end
end

return entity
