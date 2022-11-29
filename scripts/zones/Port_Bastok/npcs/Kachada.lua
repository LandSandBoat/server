-----------------------------------
-- Area: Port Bastok
--  NPC: Kachada
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer("The Vana'diel Adventurer Recruitment Program isn't running currently. World Passes aren't available for purchase at this time.", xi.msg.channel.SAY, npc:getPacketName())
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
