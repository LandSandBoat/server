-----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Telepoint
-- !pos 345.472 24.279 -114.731 90
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands_[S]/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.PASHHOW_GATE_CRYSTAL) then
        player:startEvent(1)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1 then
        npcUtil.giveKeyItem(player, xi.ki.PASHHOW_GATE_CRYSTAL)
    end
end

return entity
