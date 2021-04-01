-----------------------------------
-- Area: Xarcabard
--  NPC: qm3 (???)
-- Involved in Quests: Atop the Highest Mountains (for Boreal Coeurl)
-- !pos 580 -9 290 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not OLDSCHOOL_G2 or GetMobByID(ID.mob.BOREAL_COEURL):isDead() then
        if
            not player:hasKeyItem(xi.ki.SQUARE_FRIGICITE) and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS) == QUEST_ACCEPTED
        then
            player:addKeyItem(xi.ki.SQUARE_FRIGICITE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SQUARE_FRIGICITE)
        else
            player:messageSpecial(ID.text.ONLY_SHARDS)
        end
    else
        player:messageSpecial(ID.text.ONLY_SHARDS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
