-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: Tiger Bones
-- Involed in Quest: The Fanged One
-- !pos 666 -8 -379 120
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local fangedOne = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE)
    local fangedOneCS = player:getCharVar("TheFangedOneCS")

    -- THE FANGED ONE
    if
        fangedOne == QUEST_ACCEPTED and
        fangedOneCS == 1 and
        not GetMobByID(ID.mob.OLD_SABERTOOTH):isSpawned()
    then
        SpawnMob(ID.mob.OLD_SABERTOOTH):addStatusEffect(xi.effect.POISON, 40, 10, 210)
        player:messageSpecial(ID.text.OLD_SABERTOOTH_DIALOG_I)
    elseif
        fangedOne == QUEST_ACCEPTED and
        fangedOneCS == 2 and
        not player:hasKeyItem(xi.ki.OLD_TIGERS_FANG)
    then
        player:addKeyItem(xi.ki.OLD_TIGERS_FANG)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.OLD_TIGERS_FANG)
        player:setCharVar("TheFangedOneCS", 0)

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
