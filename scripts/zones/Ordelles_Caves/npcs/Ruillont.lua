-----------------------------------
-- Area: Ordelles Caves
--  NPC: Ruillont
-- Involved in Mission: The Rescue Drill
-- !pos -70 1 607 193
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Ruillont Default Actions vary based on Nation
    if player:getNation() == xi.nation.SANDORIA then
        player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 2)
    else
        player:showText(npc, ID.text.RUILLONT_INITIAL_DIALOG + 1)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
