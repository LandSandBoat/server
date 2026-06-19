-----------------------------------
-- Area: Al Zahbi
-- NPC: Yayaroon
-- ERA Custom Trades
-----------------------------------
require('modules/custom/lua/era_custom_trades')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.customTrades.yayaroon(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:printToPlayer('Yoooooouuu loooook like yooou wooould like some shiny things, yes?', xi.msg.channel.SAY, 'Yayaroon')
    player:queue(1000, function(p)
        p:printToPlayer('Okay, yooo got big points? Yayaroon got goooood stuff!', xi.msg.channel.SAY, 'Yayaroon')
    end)

    player:queue(2000, function(p)
        p:printToPlayer('Just yoo look on Era wiki for infooo. What\'s a wiki? I dooo not knoow!', xi.msg.channel.SAY, 'Yayaroon')
    end)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
