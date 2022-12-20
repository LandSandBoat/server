-----------------------------------
-- Area: Windurst Woods
--  NPC: Samigo-Pormigo
-- Type: Guildworker's Union Representative
-- !pos -9.782 -5.249 -134.432 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 10023, 6)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 6, 10022, "guild_bonecraft")
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10022 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 6, "guild_bonecraft")
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10022 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 6, "guild_bonecraft")
    elseif csid == 10023 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
