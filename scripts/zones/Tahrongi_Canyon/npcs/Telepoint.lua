-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Telepoint
-- !pos 100.000 35.150 340.000 117
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade any normal crystal for a faded crystal.
    local item = trade:getItemId()
    if
        trade:getItemCount() == 1 and
        item >= xi.items.FIRE_CRYSTAL and
        item <= xi.items.DARK_CRYSTAL and
        npcUtil.giveItem(player, xi.items.FADED_CRYSTAL)
    then
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.MEA_GATE_CRYSTAL) then
        player:startEvent(32)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 32 then
        npcUtil.giveKeyItem(player, xi.ki.MEA_GATE_CRYSTAL)
    end
end

return entity
