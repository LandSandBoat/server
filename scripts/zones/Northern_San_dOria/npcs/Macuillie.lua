-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Macuillie
-- Type: Guildworker's Union Representative
-- !pos -191.738 11.001 138.656 231
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 730, 2)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 2, 729, "guild_smithing")
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 729 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 2, "guild_smithing")
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 729 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 2, "guild_smithing")
    elseif csid == 730 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
