-----------------------------------
-- Area: Davoi
--  NPC: Lootblox
-- !pos 218.073 -0.982 -20.746 149
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.dynamis.hourglassAndCurrencyExchangeNPCOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.dynamis.hourglassAndCurrencyExchangeNPCOnEventFinish(player, csid, option, npc)
end

return entity
