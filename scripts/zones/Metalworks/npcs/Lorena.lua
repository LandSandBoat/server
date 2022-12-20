-----------------------------------
-- Area: Metalworks
--  NPC: Lorena
-- Type: Blacksmithing Guildworker's Union Representative
-- !pos -104.990 1 30.995 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 801, 2)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 2, 800, "guild_smithing")
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 800 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 2, "guild_smithing")
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 800 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 2, "guild_smithing")
    elseif csid == 801 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
