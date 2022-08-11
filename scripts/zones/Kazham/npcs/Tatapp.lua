-----------------------------------
-- Area: Kazham
--  NPC: Tatapp
-- Standard Merchant NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    0.532, -8.000, -87.569,
    7.720, -8.000, -88.972,
    8.935, -8.000, -90.178,
    10.142, -8.000, -91.488,
    11.468, -8.000, -93.482,
    12.613, -8.000, -96.828,
    13.596, -8.000, -101.027,
    16.654, -8.096, -117.617,
    16.574, -9.385, -123.560,
    16.313, -9.873, -128.798,
    15.083, -10.192, -133.932,
    13.719, -10.710, -139.264,
    13.938, -10.257, -142.789,
    16.414, -10.012, -145.393,
    20.226, -10.721, -146.769,
    25.940, -11.018, -148.466,
    43.709, -11.000, -152.974,
    48.625, -11.000, -150.807,
    57.275, -11.135, -145.113,
    58.448, -11.250, -141.982,
    60.327, -11.248, -138.212,
    64.383, -11.931, -133.202,
    68.261, -12.894, -130.816,
    70.109, -13.147, -128.218,
    70.648, -13.482, -125.625,
    71.451, -13.979, -119.025,
    71.839, -13.996, -115.389,
    73.030, -13.999, -110.662,
    75.995, -13.754, -99.551,
    74.584, -13.000, -96.181,
    62.251, -13.146, -95.302,
    58.039, -12.908, -94.325,
    56.185, -12.962, -92.347,
    54.388, -12.749, -88.476,
    55.681, -11.927, -84.329,
    59.031, -11.211, -75.880,
    59.596, -11.218, -70.082,
    58.904, -11.000, -66.525,
    52.639, -11.000, -65.482,
    36.273, -11.000, -64.782,
    33.880, -11.000, -64.100,
    33.389, -11.000, -63.425,
    33.199, -11.000, -62.771,
    33.032, -11.000, -61.494,
    33.037, -11.000, -59.626,
    33.211, -11.000, -56.199,
    35.018, -11.018, -27.510,
    34.135, -8.703, -9.033,
    33.712, -8.521, -8.371,
    31.135, -7.962, -7.409,
    27.810, -6.955, -7.459,
    22.801, -5.518, -10.113,
    18.782, -4.676, -13.711,
    13.004, -4.027, -18.459,
    9.726, -4.190, -19.028,
    5.676, -4.243, -19.452,
    -25.263, -4.112, -38.747,
    -26.073, -4.610, -42.731,
    -26.414, -5.149, -47.310,
    -26.613, -5.598, -50.929,
    -26.915, -6.341, -56.876,
    -27.310, -6.659, -60.889,
    -31.359, -8.085, -69.325,
    -33.897, -9.000, -75.918,
    -32.851, -9.000, -76.934,
    -29.221, -9.000, -78.977,
    -10.817, -9.916, -86.819,
    -7.741, -9.316, -87.177,
    -0.976, -8.105, -87.539,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
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
    local goodtrade = trade:hasItemQty(4599, 1)
    local badtrade = trade:hasItemQty(483, 1) or trade:hasItemQty(22, 1) or trade:hasItemQty(1157, 1) or trade:hasItemQty(1158, 1) or trade:hasItemQty(904, 1) or trade:hasItemQty(1008, 1) or trade:hasItemQty(905, 1) or trade:hasItemQty(1147, 1) or trade:hasItemQty(4600, 1)

    if opoOpoAndIStatus == QUEST_ACCEPTED then
        if progress == 6 or failed == 7 then
            if goodtrade then
                player:startEvent(225)
            elseif badtrade then
                player:startEvent(235)
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
            player:startEvent(203)
        elseif progress == 6 or failed == 7 then
                player:startEvent(212)  -- asking for blackened toad
        elseif progress >= 7 or failed >= 8 then
            player:startEvent(248) -- happy with blackened toad
        end
    else
        player:startEvent(203)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 225 then    -- correct trade, onto next opo
        if player:getCharVar("OPO_OPO_PROGRESS") == 6 then
            player:tradeComplete()
            player:setCharVar("OPO_OPO_PROGRESS", 7)
            player:setCharVar("OPO_OPO_FAILED", 0)
        else
            player:setCharVar("OPO_OPO_FAILED", 8)
        end
    elseif csid == 235 then              -- wrong trade, restart at first opo
        player:setCharVar("OPO_OPO_FAILED", 1)
        player:setCharVar("OPO_OPO_RETRY", 7)
    end
end

return entity
