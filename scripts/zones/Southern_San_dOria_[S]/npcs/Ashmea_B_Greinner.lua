-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Ashmea B Greinner
-- !pos 2 2 -81 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, 11690) -- How dare a baseborn peasant raise [his/her] voice to a noble knight!? Begone, before I strike you down myself!
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
