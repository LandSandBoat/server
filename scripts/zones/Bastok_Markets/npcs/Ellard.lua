-----------------------------------
-- Area: Bastok Markets
--  NPC: Ellard
-- Type: Guildworker's Union Representative
-- !pos -214.355 -7.814 -63.809 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 341, 3)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 340, 3)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 340 then
        xi.crafting.guildPointOnEventFinish(player, option, npc, 3)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 340 then
        xi.crafting.guildPointOnEventFinish(player, option, npc, 3)
    elseif csid == 341 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
