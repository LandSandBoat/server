-----------------------------------
-- Area: Bastok Mines
--  NPC: Hemewmew
-- Type: Guildworker's Union Representative
-- !pos 117.970 1.017 -10.438 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 207, xi.guild.ALCHEMY)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 206, xi.guild.ALCHEMY)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.ALCHEMY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.ALCHEMY)
    elseif csid == 207 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
