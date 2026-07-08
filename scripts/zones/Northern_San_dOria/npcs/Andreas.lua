-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Andreas
-- Type: Guildworker's Union Representative
-- !pos -189.282 10.999 262.626 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 732, xi.guild.WOODWORKING)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 731, xi.guild.WOODWORKING)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 731 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.WOODWORKING)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 731 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.WOODWORKING)
    elseif csid == 732 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
