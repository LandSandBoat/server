-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos -300.672 21.620 304.179 109
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 571) and npcUtil.giveItem(player, 570) then
        player:setCharVar("anExplorer-CurrentTablet", 0x00100)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
