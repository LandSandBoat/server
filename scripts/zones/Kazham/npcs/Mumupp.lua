-----------------------------------
-- Area: Kazham
--  NPC: Mumupp
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 94.732452, y = -15.000000, z = -114.034622 },
    { x = 94.210846, z = -114.989388 },
    { x = 93.508865, z = -116.274101 },
    { x = 94.584877, z = -116.522118 },
    { x = 95.646988, z = -116.468452 },
    { x = 94.613518, z = -116.616562 },
    { x = 93.791100, z = -115.858505 },
    { x = 94.841835, z = -116.108437 },
    { x = 93.823380, z = -116.712860 },
    { x = 94.986847, z = -116.571831 },
    { x = 94.165512, z = -115.965698 },
    { x = 95.005806, z = -116.519707 },
    { x = 93.935555, z = -116.706291 },
    { x = 94.943497, z = -116.578346 },
    { x = 93.996826, z = -115.932816 },
    { x = 95.060165, z = -116.180840 },
    { x = 94.081062, z = -115.923836 },
    { x = 95.246490, z = -116.215691 },
    { x = 94.234077, z = -115.960793 },
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
    local opoOpoAndIStatus = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar('OPO_OPO_PROGRESS')
    local failed = player:getCharVar('OPO_OPO_FAILED')
    local goodtrade = trade:hasItemQty(xi.item.TEN_OF_COINS_CARD, 1)
    local badtrade = trade:hasItemQty(xi.item.BROKEN_MITHRAN_FISHING_ROD, 1) or
        trade:hasItemQty(xi.item.WORKBENCH, 1) or
        trade:hasItemQty(xi.item.HANDFUL_OF_THE_SANDS_OF_SILENCE, 1) or
        trade:hasItemQty(xi.item.WANDERING_BULB, 1) or
        trade:hasItemQty(xi.item.SET_OF_GIANT_FISH_BONES, 1) or
        trade:hasItemQty(xi.item.BLACKENED_TOAD, 1) or
        trade:hasItemQty(xi.item.WYVERN_SKULL, 1) or
        trade:hasItemQty(xi.item.ROCK_OF_ANCIENT_SALT, 1) or
        trade:hasItemQty(xi.item.LUCKY_EGG, 1)

    if opoOpoAndIStatus == xi.questStatus.QUEST_ACCEPTED then
        if progress == 2 or failed == 3 then
            if goodtrade then
                player:startEvent(221)
            elseif badtrade then
                player:startEvent(231)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local opoOpoAndIStatus = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar('OPO_OPO_PROGRESS')
    local failed = player:getCharVar('OPO_OPO_FAILED')
    local retry = player:getCharVar('OPO_OPO_RETRY')

    if opoOpoAndIStatus == xi.questStatus.QUEST_ACCEPTED then
        if retry >= 1 then -- has failed on future npc so disregard previous successful trade
            player:startEvent(199)
        elseif progress == 2 or failed == 3 then
            player:startEvent(209)  -- asking for ten of coins
        elseif progress >= 3 or failed >= 4 then
            player:startEvent(244) -- happy with ten of coins
        end
    else
        player:startEvent(199)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 221 then    -- correct trade, onto next opo
        if player:getCharVar('OPO_OPO_PROGRESS') == 2 then
            player:tradeComplete()
            player:setCharVar('OPO_OPO_PROGRESS', 3)
            player:setCharVar('OPO_OPO_FAILED', 0)
        else
            player:setCharVar('OPO_OPO_FAILED', 4)
        end
    elseif csid == 231 then              -- wrong trade, restart at first opo
        player:setCharVar('OPO_OPO_FAILED', 1)
        player:setCharVar('OPO_OPO_RETRY', 3)
    end
end

return entity
