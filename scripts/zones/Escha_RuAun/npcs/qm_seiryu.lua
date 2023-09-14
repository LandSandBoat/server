-----------------------------------
-- Area: Escha Ru'Aun
--  NPC: ??? (qm_seiryu)
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")

local entity = {}

entity.onTrigger = function(player, npc)
    player:addKeyItem(xi.keyItem.SEIRYUS_NOBILITY)
    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.SEIRYUS_NOBILITY)
    GetNPCByID(ID.npc.QM_SEIRYU):setStatus(xi.status.DISAPPEAR)
end

return entity
