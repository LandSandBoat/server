-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Telepoint
-- !pos -280.942 0.597 -144.156 124
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- trade any normal crystal for a faded crystal
    local item = trade:getItemId()
    if trade:getItemCount() == 1 and item >= xi.items.FIRE_CRYSTAL and item <= xi.items.DARK_CRYSTAL and npcUtil.giveItem(player, xi.items.FADED_CRYSTAL) then
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.YHOATOR_GATE_CRYSTAL) then
        npcUtil.giveKeyItem(player, xi.ki.YHOATOR_GATE_CRYSTAL)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
