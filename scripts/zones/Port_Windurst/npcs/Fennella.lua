-----------------------------------
-- Area: Port Windurst
--  NPC: Fennella
-- Type: Guildworker's Union Representative
-- !pos -177.811 -2.835 65.639 240
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 10021, 0)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 0, 10020, "guild_fishing")
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10020 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 0, "guild_Fishing")
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10020 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 0, "guild_Fishing")
    elseif csid == 10021 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
