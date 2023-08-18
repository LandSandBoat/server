-----------------------------------
-- Area: Windurst Walls
--  NPC: Scavnix
-- Standard merchant, though he acts like a guild merchant
-- !pos 17.731 0.106 239.626 239
-----------------------------------
local ID = zones[xi.zone.WINDURST_WALLS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(60418, 11, 22, 6) then
        player:showText(npc, ID.text.SCAVNIX_SHOP_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
