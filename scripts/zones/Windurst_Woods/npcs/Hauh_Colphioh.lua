-----------------------------------
-- Area: Windurst Woods
--  NPC: Hauh Colphioh
-- Type: Guildworker's Union Representative
-- !pos -38.173 -1.25 -113.679 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 10025, xi.guild.CLOTHCRAFT)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 10024, xi.guild.CLOTHCRAFT)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10024 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.CLOTHCRAFT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10024 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.CLOTHCRAFT)
    elseif csid == 10025 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
