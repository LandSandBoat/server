-----------------------------------
-- Area: Lufaise Meadows
--  NPC: ??? - spawns Splinterspine Grukjuk for quest "A Hard Day's Knight"
-- !pos -38.605 -9.022 -290.700 24
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- NOTE: uncertain of retailness of messages. Had expected but did not find any csid.
    if (
        player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_ACCEPTED and
        player:getCharVar("SPLINTERSPINE_GRUKJUK") <= 1 and
        not GetMobByID(ID.mob.SPLINTERSPINE_GRUKJUK):isSpawned()
    ) then
        player:messageSpecial(ID.text.SURVEY_THE_SURROUNDINGS)
        player:messageSpecial(ID.text.MURDEROUS_PRESENCE)
        player:setCharVar("SPLINTERSPINE_GRUKJUK", 1)
        SpawnMob(ID.mob.SPLINTERSPINE_GRUKJUK):updateClaim(player)
    else
        player:messageSpecial(ID.text.YOU_CAN_SEE_FOR_MALMS)
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end
