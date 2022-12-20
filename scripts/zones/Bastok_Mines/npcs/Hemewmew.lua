-----------------------------------
-- Area: Bastok Mines
--  NPC: Hemewmew
-- Type: Guildworker's Union Representative
-- !pos 117.970 1.017 -10.438 234
-----------------------------------
require('scripts/globals/crafting')
require('scripts/globals/items')
require('scripts/globals/keyitems')
-----------------------------------
local ID = require('scripts/zones/Bastok_Mines/IDs')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 207, 7)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 7, 206, "guild_alchemy")
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 7, "guild_alchemy")
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 7, "guild_alchemy")
    elseif csid == 207 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
