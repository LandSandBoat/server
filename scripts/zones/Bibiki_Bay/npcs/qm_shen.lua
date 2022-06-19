-----------------------------------
-- Area: Bibiki Bay
--  NPC: ???
-- Note: Used to spawn Shen
-- !pos -115.108 0.300 -724.664 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (not GetMobByID(ID.mob.SHEN):isSpawned() and trade:hasItemQty(1823, 1) and trade:getItemCount() == 1) then
        player:tradeComplete()
        SpawnMob(ID.mob.SHEN):updateClaim(player)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
