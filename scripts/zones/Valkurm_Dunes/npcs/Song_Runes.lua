-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Song Runes
-- Finishes Quest: Path of the Bard
-- !pos -721 -7 102 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- PATH OF THE BARD (Bard Flag)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD) == QUEST_AVAILABLE and
        player:getCharVar("PathOfTheBard_Event") == 1
    then
        player:startEvent(2)

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.SONG_RUNES_DEFAULT)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 2 then
        player:unlockJob(xi.job.BRD) -- Bard
        player:messageSpecial(ID.text.UNLOCK_BARD)  --You can now become a bard!
        npcUtil.completeQuest(player, xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD, {
            fameArea = xi.quest.fame_area.JEUNO,
            fame = 30,
            title = xi.title.WANDERING_MINSTREL,
            gil = 3000,
            var = "PathOfTheBard_Event"
        })
    end
end

return entity
