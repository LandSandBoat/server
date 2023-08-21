-----------------------------------
-- Area: Bastok Mines
--  NPC: Hemewmew
-- Type: Guildworker's Union Representative
-- !pos 117.970 1.017 -10.438 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 207, 7)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 206, 7)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.guildPointOnEventFinish(player, option, npc, 7)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.guildPointOnEventFinish(player, option, npc, 7)
    elseif csid == 207 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
