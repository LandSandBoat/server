-----------------------------------
-- Area: Kazham
--  NPC: Mumupp
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    94.732452, -15.000000, -114.034622,
    94.210846, -15.000000, -114.989388,
    93.508865, -15.000000, -116.274101,
    94.584877, -15.000000, -116.522118,
    95.646988, -15.000000, -116.468452,
    94.613518, -15.000000, -116.616562,
    93.791100, -15.000000, -115.858505,
    94.841835, -15.000000, -116.108437,
    93.823380, -15.000000, -116.712860,
    94.986847, -15.000000, -116.571831,
    94.165512, -15.000000, -115.965698,
    95.005806, -15.000000, -116.519707,
    93.935555, -15.000000, -116.706291,
    94.943497, -15.000000, -116.578346,
    93.996826, -15.000000, -115.932816,
    95.060165, -15.000000, -116.180840,
    94.081062, -15.000000, -115.923836,
    95.246490, -15.000000, -116.215691,
    94.234077, -15.000000, -115.960793
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
    local goodtrade = trade:hasItemQty(1008, 1)
    local badtrade = (trade:hasItemQty(483, 1) or trade:hasItemQty(22, 1) or trade:hasItemQty(1157, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(4599, 1) or trade:hasItemQty(905, 1) or trade:hasItemQty(1147, 1) or trade:hasItemQty(4600, 1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 2 or failed == 3 then
            if goodtrade then
                player:startEvent(221)
            elseif badtrade then
                player:startEvent(231)
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
        if retry >= 1 then -- has failed on future npc so disregard previous successful trade
            player:startEvent(199)
            npc:wait()
        elseif (progress == 2 or failed == 3) then
                player:startEvent(209)  -- asking for ten of coins
        elseif (progress >= 3 or failed >= 4) then
            player:startEvent(244) -- happy with ten of coins
        end
    else
        player:startEvent(199)
        npc:wait()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)

    if (csid == 221) then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 2 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS", 3)
            player:setCharVar("OPO_OPO_FAILED", 0)
        else
            player:setCharVar("OPO_OPO_FAILED", 4)
        end
    elseif (csid == 231) then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED", 1)
        player:setCharVar("OPO_OPO_RETRY", 3)
    else
        npc:wait(0)
    end
end
