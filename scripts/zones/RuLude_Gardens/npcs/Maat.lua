-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Maat
-- Starts and Finishes Quest: Limit Break Quest 1-5
-- Involved in Quests: Beat Around the Bushin
-- !pos 8 3 118 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("BeatAroundTheBushin") == 5 then
        player:startEvent(117)
    else
        player:showText(npc, ID.text.MAAT_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 117 then
        player:setCharVar("BeatAroundTheBushin", 6)
    end
end

return entity
