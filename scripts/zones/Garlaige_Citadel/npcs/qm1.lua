-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm1 (???)
-- Involved In Quest: Altana's Sorrow
-- !pos -282.339 0.001 261.707 200
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local AltanaSorrow = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.ALTANA_S_SORROW)
    local VirnageLetter = player:hasKeyItem(tpz.ki.LETTER_FROM_VIRNAGE)
    local DivinePaint = player:hasKeyItem(tpz.ki.BUCKET_OF_DIVINE_PAINT)

    if (AltanaSorrow == QUEST_ACCEPTED and VirnageLetter == false and DivinePaint == false) then
        player:addKeyItem(tpz.ki.BUCKET_OF_DIVINE_PAINT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BUCKET_OF_DIVINE_PAINT)
    else
        player:messageSpecial(ID.text.YOU_FIND_NOTHING)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
