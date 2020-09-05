-----------------------------------
-- Area: Windurst Woods
--  NPC: Samigo-Pormigo
-- Type: Guildworker's Union Representative
-- !pos -9.782 -5.249 -134.432 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/keyitems")
-----------------------------------

local keyitems =
{
    [0] =
    {
        id = tpz.ki.BONE_PURIFICATION,
        rank = 3,
        cost = 40000
    },
    [1] =
    {
        id = tpz.ki.BONE_ENSORCELLMENT,
        rank = 3,
        cost = 40000
    },
    [2] =
    {
        id = tpz.ki.FILING,
        rank = 3,
        cost = 10000
    },
    [3] =
    {
        id = tpz.ki.WAY_OF_THE_BONEWORKER,
        rank = 9,
        cost = 20000
    }
}

local items =
{
    [0] =
    {
        id = 15449,
        rank = 3,
        cost = 10000
    },
    [1] =
    {
        id = 13947,
        rank = 6,
        cost = 70000
    },
    [2] =
    {
        id = 14397,
        rank = 7,
        cost = 100000
    },
    [3] =
    {
        id = 142, -- Drogaroga's Fang
        rank = 9,
        cost = 150000
    },
    [4] =
    {
        id = 336, -- Boneworker's Signboard
        rank = 9,
        cost = 200000
    },
    [5] =
    {
        id = 15824, -- Bonecrafter's Ring
        rank = 6,
        cost = 80000
    },
    [6] =
    {
        id = 3663, -- Bonecraft Tools
        rank = 7,
        cost = 50000
    },
    [7] =
    {
        id = 3326, -- Boneworker's Emblem
        rank = 9,
        cost = 15000
    }
}

function onTrade(player, npc, trade)
    unionRepresentativeTrade(player, npc, trade, 10023, 6)
end

function onTrigger(player, npc)
    unionRepresentativeTrigger(player, 6, 10022, "guild_bonecraft", keyitems)
end

function onEventUpdate(player, csid, option, target)
    if csid == 10022 then
        unionRepresentativeTriggerFinish(player, option, target, 6, "guild_bonecraft", keyitems, items)
    end
end

function onEventFinish(player, csid, option, target)
    if csid == 10022 then
        unionRepresentativeTriggerFinish(player, option, target, 6, "guild_bonecraft", keyitems, items)
    elseif csid == 10023 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end
