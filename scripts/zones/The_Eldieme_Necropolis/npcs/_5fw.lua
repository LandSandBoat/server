-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Tallow Candle
-- !pos 139.96 -18.29 306.27
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
local func = require("scripts/zones/The_Eldieme_Necropolis/globals")
require('scripts/globals/npc_util')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local timer = GetNPCByID(ID.npc.CANDLE_OFFSET):getLocalVar("SkullRespawn") -- 1 hour cooldown to respawn skulls

    if
        npcUtil.tradeHasExactly(trade, xi.items.FLINT_STONE) and
        os.time() > timer
    then
        func.skullTrade(player, npc)
    elseif os.time() < timer then
        player:messageSpecial(ID.text.BRAZIER_COOLDOWN)
    end
end

entity.onTrigger = function(player, npc)
    local timer = GetNPCByID(ID.npc.CANDLE_OFFSET):getLocalVar("SkullRespawn") -- 1 hour cooldown to respawn skulls
    local active = npc:getLocalVar("candlesActive")

    if os.time() < active then
        player:messageSpecial(ID.text.BRAZIER_ACTIVE)
    elseif os.time() > timer and os.time() > active then
        player:messageSpecial(ID.text.BRAZIER_OUT, 0, xi.items.FLINT_STONE)
    else
        player:messageSpecial(ID.text.BRAZIER_COOLDOWN)
    end
end

return entity
