-----------------------------------
-- Area: Bastok Markets
--  NPC: Ellard
-- Type: Guildworker's Union Representative
-- !pos -214.355 -7.814 -63.809 235
-----------------------------------
require('scripts/globals/crafting')
require('scripts/globals/items')
require('scripts/globals/keyitems')
-----------------------------------
local ID = require('scripts/zones/Bastok_Markets/IDs')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 341, 3)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 3, 340, "guild_goldsmithing")
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 340 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 3, "guild_goldsmithing")
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 340 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 3, "guild_goldsmithing")
    elseif csid == 341 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
