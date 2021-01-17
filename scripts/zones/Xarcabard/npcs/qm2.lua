-----------------------------------
-- Area: Xarcabard
--  NPC: qm2 (???)
-- Involved in Quests: Atop the Highest Mountains (for Boreal Tiger)
-- !pos 341 -29 370 112
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
    if not OLDSCHOOL_G2 or GetMobByID(ID.mob.BOREAL_TIGER):isDead() then
        if
            not player:hasKeyItem(tpz.ki.ROUND_FRIGICITE) and
            player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS) == QUEST_ACCEPTED
        then
            player:addKeyItem(tpz.ki.ROUND_FRIGICITE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ROUND_FRIGICITE)
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
