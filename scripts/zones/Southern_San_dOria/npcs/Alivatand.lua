-----------------------------------
-- Area: South San d'Oria
--  NPC: Alivatand
-- Type: Guildworker's Union Representative
-- !pos -179.458 -1 15.857 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 691, xi.guild.LEATHERCRAFT)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 690, xi.guild.LEATHERCRAFT)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 690 then
        xi.crafting.guildPointOnEventUpdate(player, option, npc, xi.guild.LEATHERCRAFT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 690 then
        xi.crafting.guildPointOnEventFinish(player, option, xi.guild.LEATHERCRAFT)
    elseif csid == 691 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
