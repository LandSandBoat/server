-----------------------------------
-- Area: Beadeaux
--  NPC: ??? (qm2)
-- Type: Quest NPC
-- !pos -79 1 -99 147
-- TODO: The ??? should only spawn during rainy weather, temporary fix in place to prevent players from getting the keyitem unless the proper weather is present.
-----------------------------------
local ID = require("scripts/zones/Beadeaux/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/world")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.BEADEAUX_SMOG) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.CORRUPTED_DIRT) == false and player:getWeather() == tpz.weather.RAIN) then
        player:addKeyItem(tpz.ki.CORRUPTED_DIRT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CORRUPTED_DIRT)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
