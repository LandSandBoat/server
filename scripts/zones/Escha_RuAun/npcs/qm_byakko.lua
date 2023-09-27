-----------------------------------
-- Area: Escha Ru'Aun
--  NPC: ??? (qm_byakko)
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")

local entity = {}

entity.onTrigger = function(player, npc)
    player:addKeyItem(xi.keyItem.BYAKKOS_PRIDE)
    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.BYAKKOS_PRIDE)
    GetNPCByID(17961730):setStatus(xi.status.DISAPPEAR)
end

return entity
