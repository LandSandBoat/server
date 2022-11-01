-----------------------------------
-- Area: Kazham
--  NPC: Lalapp
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -63.243702, y = -11.000, z = -97.916130 },
    { x = -63.970551, z = -97.229286 },
    { x = -64.771614, z = -96.499062 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
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
    local goodtrade = trade:hasItemQty(1147, 1)
    local badtrade = trade:hasItemQty(483, 1) or trade:hasItemQty(22, 1) or trade:hasItemQty(1157, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(1008, 1) or trade:hasItemQty(905, 1) or trade:hasItemQty(4599, 1) or trade:hasItemQty(4600, 1)

    if opoOpoAndIStatus == QUEST_ACCEPTED then
        if progress == 8 or failed == 9 then
            if goodtrade then
                player:startEvent(227)
            elseif badtrade then
                player:startEvent(237)
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
            player:startEvent(205)
        elseif progress == 8 or failed == 9 then
                player:startEvent(214)  -- asking for ancient salt
        elseif progress >= 9 or failed >= 10 then
            player:startEvent(250) -- happy with ancient salt
        end
    else
        player:startEvent(205)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 227 then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 8 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS", 9)
            player:setCharVar("OPO_OPO_FAILED", 0)
        else
            player:setCharVar("OPO_OPO_FAILED", 10)
        end
    elseif csid == 237 then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED", 1)
        player:setCharVar("OPO_OPO_RETRY", 9)
    end
end

return entity
