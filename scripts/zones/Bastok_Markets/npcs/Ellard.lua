-----------------------------------
-- Area: Bastok Markets
--  NPC: Ellard
-- Type: Guildworker's Union Representative
-- !pos -214.355 -7.814 -63.809 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 341, xi.guild.GOLDSMITHING)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 340, xi.guild.GOLDSMITHING)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 340 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.GOLDSMITHING)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 340 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.GOLDSMITHING)
    elseif csid == 341 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
