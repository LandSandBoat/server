-----------------------------------
-- Area: Kazham
--  NPC: Lulupp
-- !pos -26.567 -3.5 -3.544 250
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -27.457125, y = -3.043032, z = -22.057966 },
    { x = -27.373426, y = -2.772481, z = -20.974442 },
    { x = -27.103289, y = -2.500000, z = -17.846378 },
    { x = -26.864126, z = -15.667570 },
    { x = -26.532335, z = -16.636086 },
    { x = -26.505196, z = -15.471632 },
    { x = -26.509424, z = -14.359641 },
    { x = -26.564587, z = -4.499783 },
    { x = -26.574417, z = -5.523735 },
    { x = -26.580530, z = -6.591716 },
    { x = -26.583765, z = -8.555706 },
    { x = -26.501217, z = -16.563267 },
    { x = -26.504532, z = -15.427269 },
    { x = -26.509769, z = -14.327281 },
    { x = -26.565643, z = -4.247434 },
    { x = -26.573967, z = -5.299402 },
    { x = -26.579763, z = -6.379386 },
    { x = -26.580465, z = -8.155381 },
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

    if opoOpoAndIStatus == xi.questStatus.QUEST_ACCEPTED then
        if progress == 0 or failed == 1 then
            if trade:hasItemQty(xi.item.BROKEN_MITHRAN_FISHING_ROD, 1) then -- first or second time trading correctly
                player:startEvent(219)
            elseif
                trade:hasItemQty(xi.item.WORKBENCH, 1) or
                trade:hasItemQty(xi.item.TEN_OF_COINS_CARD, 1) or
                trade:hasItemQty(xi.item.HANDFUL_OF_THE_SANDS_OF_SILENCE, 1) or
                trade:hasItemQty(xi.item.WANDERING_BULB, 1) or
                trade:hasItemQty(xi.item.SET_OF_GIANT_FISH_BONES, 1) or
                trade:hasItemQty(xi.item.BLACKENED_TOAD, 1) or
                trade:hasItemQty(xi.item.WYVERN_SKULL, 1) or
                trade:hasItemQty(xi.item.ROCK_OF_ANCIENT_SALT, 1) or
                trade:hasItemQty(xi.item.LUCKY_EGG, 1)
            then
                player:startEvent(229)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local opoOpoAndIStatus = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar('OPO_OPO_PROGRESS')
    local failed = player:getCharVar('OPO_OPO_FAILED')
    local retry = player:getCharVar('OPO_OPO_RETRY')

    if
        player:getCharVar('BathedInScent') == 1 and
        opoOpoAndIStatus == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(217, 0, 483)  -- 483 broken mithran fishing rod
    elseif opoOpoAndIStatus == xi.questStatus.QUEST_ACCEPTED then
        if retry == 1 then
            player:startEvent(239) -- gave 1st NPC wrong item instead of "Broken Mithran Fishing Rod"
        elseif retry == 2 then
            player:startEvent(239, 0, 0, 1) -- gave 2nd NPC wrong item instead of "Workbench"
        elseif retry == 3 then
            player:startEvent(239, 0, 0, 2) -- gave 3rd NPC wrong item instead of "Ten of Coins"
        elseif retry == 4 then
            player:startEvent(239, 0, 0, 3) -- gave 4th NPC wrong item instead of "Sands of silence"
        elseif retry == 5 then
            player:startEvent(239, 0, 0, 4) -- gave 5th NPC wrong item instead of "Wandering Bulb"
        elseif retry == 6 then
            player:startEvent(239, 0, 0, 5) -- gave 6th NPC wrong item instead of "Giant Fish Bones"
        elseif retry == 7 then
            player:startEvent(239, 0, 0, 6) -- gave 7th NPC wrong item instead of "Blackened Toad"
        elseif retry == 8 then
            player:startEvent(239, 0, 0, 7) -- gave 8th NPC wrong item instead of "Wyvern Skull"
        elseif retry == 9 then
            player:startEvent(239, 0, 0, 8) -- gave 9th NPC wrong item instead of "Ancient Salt"
        elseif retry == 10 then
            player:startEvent(239, 0, 0, 9) -- gave 10th NPC wrong item instead of "Lucky Egg" ... uwot
        elseif progress == 0 or failed == 1 then
            player:startEvent(207)  -- asking for rod with Opoppo
        elseif progress >= 1 or failed >= 2 then
            player:startEvent(242) -- happy with rod
        end
    else
        player:startEvent(197)  -- not sure why but this cs has no text
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 217 and option == 1  then                   -- Opo Opo and I quest start CS
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_OPO_OPO_AND_I)
    elseif csid == 219 then
        if player:getCharVar('OPO_OPO_PROGRESS') == 0 then
            player:tradeComplete()
            player:setCharVar('OPO_OPO_PROGRESS', 1)
        else
            player:setCharVar('OPO_OPO_FAILED', 2)
        end
    elseif csid == 229 then                                -- Traded wrong item, saving current progress to not take item up to this point
        player:setCharVar('OPO_OPO_RETRY', 1)
    elseif csid == 239 and option == 1 then                -- Traded wrong to another NPC, give a clue
        player:setCharVar('OPO_OPO_RETRY', 0)
        player:setCharVar('OPO_OPO_FAILED', 1)
    end
end

return entity
