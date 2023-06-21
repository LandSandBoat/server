-----------------------------------
-- Area: Jugner Forest [S]
--  NPC: Telepoint
-- !pos -122.862 0.000 -163.154 82
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.JUGNER_GATE_CRYSTAL) then
        player:startEvent(1)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1 then
        npcUtil.giveKeyItem(player, xi.ki.JUGNER_GATE_CRYSTAL)
    end
end

return entity
