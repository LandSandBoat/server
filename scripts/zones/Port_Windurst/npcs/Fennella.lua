-----------------------------------
-- Area: Port Windurst
--  NPC: Fennella
-- Type: Guildworker's Union Representative
-- !pos -177.811 -2.835 65.639 240
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 10021, xi.guild.FISHING)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 10020, xi.guild.FISHING)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10020 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.FISHING)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10020 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.FISHING)
    elseif csid == 10021 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
