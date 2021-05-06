-----------------------------------
-- Area: Arrapago Remnants
--  NPC: Slot
-- trade card to pop NM
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 2377) then
        local instance = npc:getInstance()
        SpawnMob(ID.mob[2][2].princess, instance):updateClaim(player)
        player:confirmTrade()
    end
end

entity.onTrigger = function(entity, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(entity, eventid, result)
end

return entity
