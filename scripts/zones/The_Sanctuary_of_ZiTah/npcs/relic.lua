-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  NPC: <this space intentionally left blank>
-- !pos 646 -2 -165 121
-- !pos -18 0 55 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    local currentRelic = player:getCharVar("RELIC_IN_PROGRESS")

    -- Mandau
    if currentRelic == 18269 and npcUtil.tradeHas(trade, {1457, 1572, 1589, 18269}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(207, 18270)

    -- Mjollnir
    elseif currentRelic == 18323 and npcUtil.tradeHas(trade, {1454, 1581, 1589, 18323}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(216, 18324)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 207 and npcUtil.giveItem(player, {18270, {1456, 30}}) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    elseif csid == 216 and npcUtil.giveItem(player, {18324, {1453, 30}}) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
