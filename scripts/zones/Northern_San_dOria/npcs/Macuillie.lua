-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Macuillie
-- Type: Guildworker's Union Representative
-- !pos -191.738 11.001 138.656 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointNPConTrade(player, npc, trade, 730, 2)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointNPConTrigger(player, 2, 729)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 729 then
        xi.crafting.guildPointNPConEventFinish(player, option, npc, 2)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 729 then
        xi.crafting.guildPointNPConEventFinish(player, option, npc, 2)
    elseif csid == 730 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
