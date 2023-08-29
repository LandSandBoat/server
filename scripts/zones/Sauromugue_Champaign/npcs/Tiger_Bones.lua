-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: Tiger Bones
-- Involed in Quest: The Fanged One
-- !pos 666 -8 -379 120
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local fangedOne = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE)
    local fangedOneCS = player:getCharVar("Quest[2][31]Prog")
    local timer = player:getCharVar("Quest[2][31]Timer")

    -- THE FANGED ONE
    local tiger = GetMobByID(ID.mob.OLD_SABERTOOTH)
    if
        fangedOne == QUEST_ACCEPTED and
        fangedOneCS == 1 and
        not tiger:isSpawned() and
        os.time() > timer
    then
        SpawnMob(tiger:getID()):updateClaim(player)
        tiger:addStatusEffect(xi.effect.POISON, 10, 10, 500)
        player:messageSpecial(ID.text.OLD_SABERTOOTH_DIALOG_I)
    elseif
        fangedOne == QUEST_ACCEPTED and
        fangedOneCS == 2 and
        not player:hasKeyItem(xi.ki.OLD_TIGERS_FANG)
    then
        player:addKeyItem(xi.ki.OLD_TIGERS_FANG)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.OLD_TIGERS_FANG)
        player:setCharVar("Quest[2][31]Timer", 0)

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
