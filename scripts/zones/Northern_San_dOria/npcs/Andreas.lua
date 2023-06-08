-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Andreas
-- Type: Guildworker's Union Representative
-- !pos -189.282 10.999 262.626 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointNPConTrade(player, npc, trade, 732, 1)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointNPConTrigger(player, 731, 1)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 731 then
        xi.crafting.guildPointNPConEventFinish(player, option, npc, 1)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 731 then
        xi.crafting.guildPointNPConEventFinish(player, option, npc, 1)
    elseif csid == 732 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
