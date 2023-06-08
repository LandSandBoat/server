-----------------------------------
-- Area: Bastok Mines
--  NPC: Hemewmew
-- Type: Guildworker's Union Representative
-- !pos 117.970 1.017 -10.438 234
-----------------------------------
local ID = require('scripts/zones/Bastok_Mines/IDs')
require('scripts/globals/crafting')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointNPConTrade(player, npc, trade, 207, 7)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointNPConTrigger(player, 206, 7)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.guildPointNPConEventFinish(player, option, npc, 7)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.guildPointNPConEventFinish(player, option, npc, 7)
    elseif csid == 207 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
