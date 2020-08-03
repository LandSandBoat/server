-----------------------------------
-- Area: Port Bastok
--  NPC: Festive Moogle
-- Type: Event NPC
--  !pos 46.902 8.499 -242.276 236
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
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
local festiveItemVars = {
    [1] = "festiveMoogleNomadCap",
    [2] = "festiveMoogleMoogleCap",
    [3] = "festiveMoogleMoogleRod",
    [4] = "festiveMoogleHarpsichord",
    [5] = "festiveMooglestuffedChocobo",
    [6] = "festiveMoogleTidalTalisman",
    [7] = "festiveMoogleDestrierBeret",
    [8] = "festiveMoogleChocoboShirt",
}
function onTrade(player,npc,trade)
    --TODO: trade of pells for prize
end

function onTrigger(player, npc)
    local festiveItems = getFestiveItems(player)
    if festiveItems[1] then
        player:startEvent(380, unpack(festiveItems))
    else
        player:startEvent(381)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local festiveItems = getFestiveItems(player)
    if csid == 380 then
        if npcUtil.giveItem(player, festiveItems[option]) then
            for i = 1, #stock do
                if stock[i] == festiveItems[option] then
                    player:setCharVar(festiveItemVars[i], 0)
                    break
                end
            end
        end
    end
end

function getFestiveItems(player)
    local festiveItemsAvailable = {}

    for i = 1, #festiveItemVars, 1 do
        if player:getCharVar(festiveItemVars[i]) == 1 then
            table.insert(festiveItemsAvailable, stock[i])
        end
    end
    return festiveItemsAvailable
end
