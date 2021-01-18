-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Hae Jakhya
--  General Info NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local chasingStatus = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.CHASING_TALES)

    if (player:getCharVar("CHASING_TALES_TRACK_BOOK") == 1 and player:hasKeyItem(tpz.ki.A_SONG_OF_LOVE) == false) then
        player:startEvent(611) -- Neeed CS here
    elseif (player:hasKeyItem(tpz.ki.A_SONG_OF_LOVE) == true) then
        player:startEvent(612, 0, tpz.ki.A_SONG_OF_LOVE)
    else
        player:startEvent(610)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 611) then
        player:addKeyItem(tpz.ki.A_SONG_OF_LOVE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.A_SONG_OF_LOVE)
    end
end

return entity
