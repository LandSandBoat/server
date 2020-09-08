-----------------------------------
-- Area: Port Bastok
--  NPC: Festive Moogle
-- Type: Event NPC
--  !pos 46.902 8.499 -242.276 236
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    --TODO: trade of pells for prize
end

function onTrigger(player, npc)
    local festiveItems = {getFestiveItems(player)}
    if festiveItems[1] then
        player:startEvent(380, unpack(festiveItems))
    else
        player:startEvent(381)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local festiveItems = {getFestiveItems(player)}
    if csid == 380 then
        npcUtil.giveItem(player, festiveItems[option])
    end
end

function getFestiveItems(player)
    local festiveItemsAvailable = {}
    local stock = {
        16119,  -- Nomad Cap
        16118,  -- Moogle Cap
        18401,  -- Moogle Rod
        320,    -- Harpsichord
        264,    -- Stuffed Chocobo
        11290,  -- Tidal Talisman
        11811,  -- Destrier Beret
        10293,  -- Chocobo Shirt
    }
    local festiveItems = {
        [1] = player:getCharVar("festiveMoogleNomadCap"),
        [2] = player:getCharVar("festiveMoogleMoogleCap"),
        [3] = player:getCharVar("festiveMoogleMoogleRod"),
        [4] = player:getCharVar("festiveMoogleHarpsichord"),
        [5] = player:getCharVar("festiveMooglestuffedChocobo"),
        [6] = player:getCharVar("festiveMoogleTidalTalisman"),
        [7] = player:getCharVar("festiveMoogleDestrierBeret"),
        [8] = player:getCharVar("festiveMoogleChocoboShirt"),
    }
    for i = 1, #festiveItems, 1 do
        if festiveItems[i] == 1 then
            festiveItemsAvailable[i] = stock[i]
        end
    end
    return unpack(festiveItemsAvailable)
end
