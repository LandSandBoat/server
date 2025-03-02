-----------------------------------
-- Area: Windurst Woods
--  NPC: Samigo-Pormigo
-- Type: Guildworker's Union Representative
-- !pos -9.782 -5.249 -134.432 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 10023, xi.guild.BONECRAFT)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 10022, xi.guild.BONECRAFT)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10022 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.BONECRAFT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10022 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.BONECRAFT)
    elseif csid == 10023 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
