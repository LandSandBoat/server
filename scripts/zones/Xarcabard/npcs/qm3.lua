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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not OLDSCHOOL_G2 or GetMobByID(ID.mob.BOREAL_COEURL):isDead() then
        if
            not player:hasKeyItem(tpz.ki.SQUARE_FRIGICITE) and
            player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS) == QUEST_ACCEPTED
        then
            player:addKeyItem(tpz.ki.SQUARE_FRIGICITE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SQUARE_FRIGICITE)
        else
            player:messageSpecial(ID.text.ONLY_SHARDS)
        end
    else
        player:messageSpecial(ID.text.ONLY_SHARDS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
