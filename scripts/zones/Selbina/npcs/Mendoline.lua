-----------------------------------
-- Area: Selbina
--  NPC: Mendoline
-- Guild Merchant NPC: Fishing Guild
-- !pos -13.603 -7.287 10.916 248
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(5182, 3, 18, 5) then
        player:showText(npc, ID.text.FISHING_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
