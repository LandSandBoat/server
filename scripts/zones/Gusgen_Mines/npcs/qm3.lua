-----------------------------------
-- Area: Gusgen Mines
--  NPC: qm3 (???)
-- Involved In Quest: Healing the Land
-- !pos -168 1 311 196
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Gusgen_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local HealingTheLand = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.HEALING_THE_LAND)

    if (HealingTheLand == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SEAL_OF_BANISHING) == true) then
        player:delKeyItem(tpz.ki.SEAL_OF_BANISHING)
        player:messageSpecial(ID.text.FOUND_LOCATION_SEAL, tpz.ki.SEAL_OF_BANISHING)
    elseif (HealingTheLand == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SEAL_OF_BANISHING) == false) then
        player:messageSpecial(ID.text.IS_ON_THIS_SEAL, tpz.ki.SEAL_OF_BANISHING)
    else
        player:messageSpecial(ID.text.LETTERS_IS_WRITTEN_HERE)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
