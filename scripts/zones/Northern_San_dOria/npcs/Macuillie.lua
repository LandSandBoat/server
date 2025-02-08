-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Macuillie
-- Type: Guildworker's Union Representative
-- !pos -191.738 11.001 138.656 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 730, xi.guild.SMITHING)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 729, xi.guild.SMITHING)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 729 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.SMITHING)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 729 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.SMITHING)
    elseif csid == 730 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
