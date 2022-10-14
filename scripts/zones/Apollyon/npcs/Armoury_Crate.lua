-----------------------------------
-- Area: Apollyon
--  NPC: Armoury Crate
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/limbus")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

local loot =
{
    -- Central Apollyon
    [1296] =
    {
        -- Proto-Omega
        [1] =
        {
            {
                { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
            },

            {
                { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
            },

            {
                { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
            },

            {
                { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
            },

            {
                { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
            },

            {
                { itemid =    0, droprate = 1000 }, -- Nothing
                { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
            },

            {
                { itemid = 1925, droprate = 659 }, -- Omega's Eye
                { itemid = 1927, droprate = 394 }, -- Omega's Foreleg
                { itemid = 1928, droprate = 388 }, -- Omega's Hinf Leg
                { itemid = 1929, droprate = 404 }, -- Omega's Tail
            },

            {
                { itemid = 1928, droprate = 394 }, -- Omega's Hind Leg
                { itemid = 1929, droprate = 402 }, -- Omega's Tail
                { itemid = 1925, droprate = 659 }, -- Omega's Eye
                { itemid = 1927, droprate = 383 }, -- Omega's Foreleg
            },

            {
                { itemid =    0, droprate = 735 }, -- Nothing
                { itemid = 1926, droprate = 265 }, -- Omega's Heart
            },
        },
    },
}

entity.onTrade = function(player,npc,trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()

    if not battlefield then
        return
    end

    local crateID = npc:getID()
    local model   = npc:getModelId()
    local bfid    = battlefield:getID()
    local hold    = false

    if npc:getLocalVar("open") == 0 then
        switch (bfid): caseof
        {
            -- NW Apollyon Crate Handling
            [1290] = function()
                if crateID ~= ID.npc.APOLLYON_NW_CRATE[5] then
                    for i = 1, 4 do
                        for j = 1, 5 do
                            if crateID == ID.npc.APOLLYON_NW_CRATE[i][j] then
                                if model == 960 then
                                    xi.battlefield.HealPlayers(battlefield) -- HP/MP Chest.
                                elseif model == 961 then
                                    xi.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc) -- Item Chest.
                                elseif model == 962 then
                                    xi.limbus.extendTimeLimit(battlefield, 5, xi.zone.APOLLYON) -- Time chest.
                                end
                            end
                        end
                    end
                else
                    xi.limbus.handleLootRolls(battlefield, loot[bfid][5], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,

            -- Central Apollyon Crate Handling
            [1296] = function()
                xi.limbus.handleLootRolls(battlefield, loot[bfid][1], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
        }

        if not hold then
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npcArg)
                npcArg:entityAnimationPacket("kesu")
            end)
            npc:timer(16000, function(npcArg)
                npcArg:setStatus(xi.status.DISAPPEAR)
                npcArg:timer(500, function(mobArg)
                    mobArg:setLocalVar("open", 0)
                end)
            end)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
