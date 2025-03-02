-----------------------------------
-- Area: Metalworks
--  NPC: Lorena
-- Type: Blacksmithing Guildworker's Union Representative
-- !pos -104.990 1 30.995 237
-----------------------------------
local ID = zones[xi.zone.METALWORKS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 801, xi.guild.SMITHING)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 800, xi.guild.SMITHING)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 800 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.SMITHING)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 800 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.SMITHING)
    elseif csid == 801 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
