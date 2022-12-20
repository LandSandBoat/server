-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Andreas
-- Type: Guildworker's Union Representative
-- !pos -189.282 10.999 262.626 231
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 732, 1)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 1, 731, "guild_woodworking")
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 731 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 1, "guild_woodworking")
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 731 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 1, "guild_woodworking")
    elseif csid == 732 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
