-----------------------------------
-- Area: Escha Ru'Aun
--  NPC: ??? (qm_genbu)
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")

local entity = {}

entity.onTrigger = function(player, npc)
    player:addKeyItem(xi.keyItem.GENBUS_HONOR)
    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.keyItem.GENBUS_HONOR)
    GetNPCByID(ID.npc.QM_GENBU):setStatus(xi.status.DISAPPEAR)
end

return entity
