-----------------------------------
-- Area: Kazham
--  NPC: Lulupp
-- Type: Standard NPC
-- !pos -26.567 -3.5 -3.544 250
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    -27.457125, -3.043032, -22.057966,
    -27.373426, -2.772481, -20.974442,
    -27.103289, -2.500000, -17.846378,
    -26.864126, -2.500000, -15.667570,
    -26.532335, -2.500000, -16.636086,
    -26.505196, -2.500000, -15.471632,
    -26.509424, -2.500000, -14.359641,
    -26.564587, -2.500000, -4.499783,
    -26.574417, -2.500000, -5.523735,
    -26.580530, -2.500000, -6.591716,
    -26.583765, -2.500000, -8.555706,
    -26.501217, -2.500000, -16.563267,
    -26.504532, -2.500000, -15.427269,
    -26.509769, -2.500000, -14.327281,
    -26.565643, -2.500000, -4.247434,
    -26.573967, -2.500000, -5.299402,
    -26.579763, -2.500000, -6.379386,
    -26.580465, -2.500000, -8.155381
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
    local goodtrade = trade:hasItemQty(483, 1)
    local badtrade = (trade:hasItemQty(22, 1) or trade:hasItemQty(1008, 1) or trade:hasItemQty(1157, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(4599, 1) or trade:hasItemQty(905, 1) or trade:hasItemQty(1147, 1) or trade:hasItemQty(4600, 1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 0 or failed == 1 then
            if goodtrade then                   -- first or second time trading correctly
                player:startEvent(219)
            elseif badtrade then
                player:startEvent(229)
            end
        end
    end
end

function onTrigger(player, npc)
    local OpoOpoAndIStatus = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar("OPO_OPO_PROGRESS")
    local failed = player:getCharVar("OPO_OPO_FAILED")
    local retry = player:getCharVar("OPO_OPO_RETRY")

    if (player:getCharVar("BathedInScent") == 1 and OpoOpoAndIStatus == QUEST_AVAILABLE) then
        player:startEvent(217, 0, 483)  -- 483 broken mithran fishing rod
        npc:wait()
    elseif (OpoOpoAndIStatus == QUEST_ACCEPTED) then
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
        elseif (progress == 0 or failed == 1) then
            player:startEvent(207)  -- asking for rod with Opoppo
        elseif (progress >= 1 or failed >= 2) then
            player:startEvent(242) -- happy with rod
        end
    else
        player:startEvent(197)  -- not sure why but this cs has no text
        npc:wait()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 217 and option == 1)  then                   -- Opo Opo and I quest start CS
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.THE_OPO_OPO_AND_I)
    elseif (csid == 219) then
        if (player:getCharVar("OPO_OPO_PROGRESS") == 0) then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS", 1)
        else
            player:setCharVar("OPO_OPO_FAILED", 2)
        end
    elseif (csid == 229) then                                -- Traded wrong item, saving current progress to not take item up to this point
        player:setCharVar("OPO_OPO_RETRY", 1)
    elseif (csid == 239 and option == 1) then                -- Traded wrong to another NPC, give a clue
        player:setCharVar("OPO_OPO_RETRY", 0)
        player:setCharVar("OPO_OPO_FAILED", 1)
    else
        npc:wait(0)
    end
end
