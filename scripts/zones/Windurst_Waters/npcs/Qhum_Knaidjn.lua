-----------------------------------
-- Area: Windurst Waters
--  NPC: Qhum_Knaidjn
-- Type: Guildworker's Union Representative
-- !pos -112.561 -2 55.205 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 10025, xi.guild.COOKING)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 10024, xi.guild.COOKING)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10024 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.COOKING)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10024 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.COOKING)
    elseif csid == 10025 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
