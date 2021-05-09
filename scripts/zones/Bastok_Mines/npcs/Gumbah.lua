-----------------------------------
-- Area: Bastok Mines
--  NPC: Gumbah
-- Finishes Quest: Blade of Darkness, Inheritance
-- !pos 52 0 -36 234
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local bladeDarkness = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS)

    if player:getMainLvl() >= ADVANCED_JOB_LEVEL and bladeDarkness == QUEST_AVAILABLE then
        --DARK KNIGHT QUEST
        player:startEvent(99)
    elseif bladeDarkness == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH) == QUEST_AVAILABLE then
        player:startEvent(130)
    elseif ((player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.ON_MY_WAY) == true)
    or ((player:getCurrentMission(BASTOK) == xi.mission.id.bastok.ON_MY_WAY) and (player:getMissionStatus(player:getNation()) == 3)))
        and (player:getCharVar("[B7-2]Werei") == 0) then
        player:startEvent(177)
    else
        --DEFAULT
        player:startEvent(52)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 99 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS)
    elseif csid == 130 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH)
        player:addKeyItem(xi.ki.LETTER_FROM_ZEID)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_FROM_ZEID)
    elseif csid == 177 then
        player:setCharVar("[B7-2]Werei", 1)
    end
end

return entity
