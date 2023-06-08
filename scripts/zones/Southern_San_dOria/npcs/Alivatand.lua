-----------------------------------
-- Area: South San d'Oria
--  NPC: Alivatand
-- Type: Guildworker's Union Representative
-- !pos -179.458 -1 15.857 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointNPConTrade(player, npc, trade, 691, 5)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointNPConTrigger(player, 690, 5)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 690 then
        xi.crafting.guildPointNPConEventFinish(player, option, npc, 5)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 690 then
        xi.crafting.guildPointNPConEventFinish(player, option, npc, 5)
    elseif csid == 691 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
