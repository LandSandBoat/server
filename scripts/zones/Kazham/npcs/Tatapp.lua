-----------------------------------
-- Area: Kazham
--  NPC: Tatapp
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 0.532, y = -8.000, z = -87.569 },
    { x = 7.720, z = -88.972 },
    { x = 8.935, z = -90.178 },
    { x = 10.142, z = -91.488 },
    { x = 11.468, z = -93.482 },
    { x = 12.613, z = -96.828 },
    { x = 13.596, z = -101.027 },
    { x = 16.654, y = -8.096, z = -117.617 },
    { x = 16.574, y = -9.385, z = -123.560 },
    { x = 16.313, y = -9.873, z = -128.798 },
    { x = 15.083, y = -10.192, z = -133.932 },
    { x = 13.719, y = -10.710, z = -139.264 },
    { x = 13.938, y = -10.257, z = -142.789 },
    { x = 16.414, y = -10.012, z = -145.393 },
    { x = 20.226, y = -10.721, z = -146.769 },
    { x = 25.940, y = -11.018, z = -148.466 },
    { x = 43.709, y = -11.000, z = -152.974 },
    { x = 48.625, z = -150.807 },
    { x = 57.275, y = -11.135, z = -145.113 },
    { x = 58.448, y = -11.250, z = -141.982 },
    { x = 60.327, y = -11.248, z = -138.212 },
    { x = 64.383, y = -11.931, z = -133.202 },
    { x = 68.261, y = -12.894, z = -130.816 },
    { x = 70.109, y = -13.147, z = -128.218 },
    { x = 70.648, y = -13.482, z = -125.625 },
    { x = 71.451, y = -13.979, z = -119.025 },
    { x = 71.839, y = -13.996, z = -115.389 },
    { x = 73.030, y = -13.999, z = -110.662 },
    { x = 75.995, y = -13.754, z = -99.551 },
    { x = 74.584, y = -13.000, z = -96.181 },
    { x = 62.251, y = -13.146, z = -95.302 },
    { x = 58.039, y = -12.908, z = -94.325 },
    { x = 56.185, y = -12.962, z = -92.347 },
    { x = 54.388, y = -12.749, z = -88.476 },
    { x = 55.681, y = -11.927, z = -84.329 },
    { x = 59.031, y = -11.211, z = -75.880 },
    { x = 59.596, y = -11.218, z = -70.082 },
    { x = 58.904, y = -11.000, z = -66.525 },
    { x = 52.639, z = -65.482 },
    { x = 36.273, z = -64.782 },
    { x = 33.880, z = -64.100 },
    { x = 33.389, z = -63.425 },
    { x = 33.199, z = -62.771 },
    { x = 33.032, z = -61.494 },
    { x = 33.037, z = -59.626 },
    { x = 33.211, z = -56.199 },
    { x = 35.018, y = -11.018, z = -27.510 },
    { x = 34.135, y = -8.703, z = -9.033 },
    { x = 33.712, y = -8.521, z = -8.371 },
    { x = 31.135, y = -7.962, z = -7.409 },
    { x = 27.810, y = -6.955, z = -7.459 },
    { x = 22.801, y = -5.518, z = -10.113 },
    { x = 18.782, y = -4.676, z = -13.711 },
    { x = 13.004, y = -4.027, z = -18.459 },
    { x = 9.726, y = -4.190, z = -19.028 },
    { x = 5.676, y = -4.243, z = -19.452 },
    { x = -25.263, y = -4.112, z = -38.747 },
    { x = -26.073, y = -4.610, z = -42.731 },
    { x = -26.414, y = -5.149, z = -47.310 },
    { x = -26.613, y = -5.598, z = -50.929 },
    { x = -26.915, y = -6.341, z = -56.876 },
    { x = -27.310, y = -6.659, z = -60.889 },
    { x = -31.359, y = -8.085, z = -69.325 },
    { x = -33.897, y = -9.000, z = -75.918 },
    { x = -32.851, z = -76.934 },
    { x = -29.221, z = -78.977 },
    { x = -10.817, y = -9.916, z = -86.819 },
    { x = -7.741, y = -9.316, z = -87.177 },
    { x = -0.976, y = -8.105, z = -87.539 },
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
    local goodtrade = trade:hasItemQty(xi.item.BLACKENED_TOAD, 1)
    local badtrade = trade:hasItemQty(xi.item.BROKEN_MITHRAN_FISHING_ROD, 1) or
        trade:hasItemQty(xi.item.WORKBENCH, 1) or
        trade:hasItemQty(xi.item.HANDFUL_OF_THE_SANDS_OF_SILENCE, 1) or
        trade:hasItemQty(xi.item.WANDERING_BULB, 1) or
        trade:hasItemQty(xi.item.SET_OF_GIANT_FISH_BONES, 1) or
        trade:hasItemQty(xi.item.TEN_OF_COINS_CARD, 1) or
        trade:hasItemQty(xi.item.WYVERN_SKULL, 1) or
        trade:hasItemQty(xi.item.ROCK_OF_ANCIENT_SALT, 1) or
        trade:hasItemQty(xi.item.LUCKY_EGG, 1)

    if opoOpoAndIStatus == xi.questStatus.QUEST_ACCEPTED then
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
    local opoOpoAndIStatus = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_OPO_OPO_AND_I)
    local progress = player:getCharVar('OPO_OPO_PROGRESS')
    local failed = player:getCharVar('OPO_OPO_FAILED')
    local retry = player:getCharVar('OPO_OPO_RETRY')

    if opoOpoAndIStatus == xi.questStatus.QUEST_ACCEPTED then
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

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 225 then    -- correct trade, onto next opo
        if player:getCharVar('OPO_OPO_PROGRESS') == 6 then
            player:tradeComplete()
            player:setCharVar('OPO_OPO_PROGRESS', 7)
            player:setCharVar('OPO_OPO_FAILED', 0)
        else
            player:setCharVar('OPO_OPO_FAILED', 8)
        end
    elseif csid == 235 then              -- wrong trade, restart at first opo
        player:setCharVar('OPO_OPO_FAILED', 1)
        player:setCharVar('OPO_OPO_RETRY', 7)
    end
end

return entity
