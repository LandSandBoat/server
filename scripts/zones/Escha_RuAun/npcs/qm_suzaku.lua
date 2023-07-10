-----------------------------------
-- Area: Escha Ru'Aun
--  NPC: ??? (qm_suzaku)
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")

local entity = {}

entity.onTrigger = function(player, npc)
    player:addKeyItem(xi.keyItem.SUZAKUS_BENEFACTION)
    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SUZAKUS_BENEFACTION)
    GetNPCByID(ID.npc.QM_SUZAKU):setStatus(xi.status.DISAPPEAR)
end

return entity
