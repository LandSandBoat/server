-----------------------------------
-- Area: Kazham
--  NPC: Kukupp
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")

local path =
{
    43.067505, -11.000000, -177.214966,
    43.583324, -11.000000, -178.104263,
    44.581100, -11.000000, -178.253067,
    45.459488, -11.000000, -177.616653,
    44.988266, -11.000000, -176.728577,
    43.920345, -11.000000, -176.549469,
    42.843422, -11.000000, -176.469452,
    41.840969, -11.000000, -176.413971,
    41.849968, -11.000000, -177.460236,
    42.699162, -11.000000, -178.046478,
    41.800228, -11.000000, -177.440720,
    40.896564, -11.000000, -176.834793,
    41.800350, -11.000000, -177.440704,
    43.494385, -11.000000, -178.577087,
    44.525345, -11.000000, -178.332214,
    45.382175, -11.000000, -177.664185,
    44.612972, -11.000000, -178.457062,
    43.574627, -11.000000, -178.455185,
    42.603222, -11.000000, -177.950760,
    41.747925, -11.000000, -177.402481,
    40.826141, -11.000000, -176.787674,
    41.709877, -11.000000, -177.380173,
    42.570263, -11.000000, -177.957306,
    43.600094, -11.000000, -178.648087,
    44.603924, -11.000000, -178.268082,
    45.453266, -11.000000, -177.590103,
    44.892513, -11.000000, -176.698730,
    43.765514, -11.000000, -176.532211,
    42.616215, -11.000000, -176.454498,
    41.549683, -11.000000, -176.399078,
    42.671898, -11.000000, -176.463196,
    43.670380, -11.000000, -176.518692,
    45.595409, -11.000000, -176.626129,
    44.485180, -11.000000, -176.564041,
    43.398880, -11.000000, -176.503586,
    40.778934, -11.000000, -176.357834,
    41.781410, -11.000000, -176.413223,
    42.799843, -11.000000, -176.469894,
    45.758560, -11.000000, -176.782486,
    45.296803, -11.000000, -177.683472,
    44.568489, -11.000000, -178.516357,
    45.321579, -11.000000, -177.759048,
    45.199261, -11.000000, -176.765274,
    44.072094, -11.000000, -176.558044,
    43.054935, -11.000000, -176.482895,
    41.952633, -11.000000, -176.421570,
    43.014915, -11.000000, -176.482178,
    45.664345, -11.000000, -176.790253,
    45.225407, -11.000000, -177.712463,
    44.465252, -11.000000, -178.519577,
    43.388020, -11.000000, -178.364532,
    42.406048, -11.000000, -177.838013,
    41.515419, -11.000000, -177.255875,
    40.609776, -11.000000, -176.645706
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
    local goodtrade = trade:hasItemQty(22, 1)
    local badtrade = (trade:hasItemQty(483, 1) or trade:hasItemQty(1008, 1) or trade:hasItemQty(1157, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(4599, 1) or trade:hasItemQty(905, 1) or trade:hasItemQty(1147, 1) or trade:hasItemQty(4600, 1))

    if (OpoOpoAndIStatus == QUEST_ACCEPTED) then
        if progress == 1 or failed == 2 then
            if goodtrade then
                player:startEvent(220)
            elseif badtrade then
                player:startEvent(230)
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
            player:startEvent(198)
            npc:wait()
        elseif (progress == 1 or failed == 2) then
                player:startEvent(208)  -- asking for workbench
        elseif (progress >= 2 or failed >= 3) then
            player:startEvent(243) -- happy with workbench
        end
    else
        player:startEvent(198)
        npc:wait()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)

    if (csid == 220) then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 1 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS", 2)
            player:setCharVar("OPO_OPO_FAILED", 0)
        else
            player:setCharVar("OPO_OPO_FAILED", 3)
        end
    elseif (csid == 230) then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED", 1)
        player:setCharVar("OPO_OPO_RETRY", 2)
    else
        npc:wait(0)
    end
end
