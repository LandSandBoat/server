-----------------------------------
-- Area: Port Windurst
--  NPC: Babubu
-- Guild Merchant NPC: Fishing Guild
-- !pos -175.185 -3.324 70.445 240
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(517, 3, 18, 5) then
        player:showText(npc, ID.text.BABUBU_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
