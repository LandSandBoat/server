-----------------------------------
-- Area: Ship bound for Selbina Pirates
--  NPC: Rajmonda
-- Type: Guild Merchant: Fishing Guild
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(520, 1, 23, 5) then
        player:showText(npc, ID.text.RAJMONDA_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
