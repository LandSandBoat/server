-----------------------------------
-- Area: Grauberg [S]
--  NPC: ???
--  Quest - DNC AF1
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local tuw = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ)
    local tuwStatus = player:getCharVar("QuestStatus_DNC_AF1")

    if (tuw == QUEST_ACCEPTED and tuwStatus == 2) then
        player:startEvent(12)
    elseif (tuw == QUEST_ACCEPTED and tuwStatus == 3 and not GetMobByID(ID.mob.MIGRATORY_HIPPOGRYPH):isSpawned()) then
        SpawnMob(ID.mob.MIGRATORY_HIPPOGRYPH):updateEnmity(player)
    elseif (tuw == QUEST_ACCEPTED and tuwStatus == 4) then
        player:startEvent(13)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid==12) then
        player:setCharVar("QuestStatus_DNC_AF1", 3)
    elseif (csid==13) then
        player:addKeyItem(tpz.ki.THE_ESSENCE_OF_DANCE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.THE_ESSENCE_OF_DANCE)
        player:setCharVar("QuestStatus_DNC_AF1", 5)
    end
end
