-----------------------------------
-- Area: Davoi
--  NPC: Hide Flap
-- Involved in Quest: The Doorman, The First Meeting
-- !pos 293 3 -213 149 (WAR)(K-9)
-- !pos -124 3 -43 149 (MNK)(F-7)
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.HIDE_FLAP_OFFSET

    -- THE DOORMAN
    if offset == 0 and player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_DOORMAN) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.SWORD_GRIP_MATERIAL) then
        if player:getCharVar("theDoormanKilledNM") >= 2 then
            npcUtil.giveKeyItem(player, tpz.ki.SWORD_GRIP_MATERIAL)
            player:setCharVar("theDoormanMyMob", 0)
            player:setCharVar("theDoormanKilledNM", 0)
        elseif not GetMobByID(ID.mob.GAVOTVUT):isSpawned() and not GetMobByID(ID.mob.BARAKBOK):isSpawned() then
            SpawnMob(ID.mob.GAVOTVUT):updateClaim(player)
            SpawnMob(ID.mob.BARAKBOK):updateClaim(player)
            player:setCharVar("theDoormanMyMob", 1)
        end

    -- THE FIRST MEETING
    elseif offset == 1 and player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_FIRST_MEETING) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.SANDORIAN_MARTIAL_ARTS_SCROLL) then
        if player:getCharVar("theFirstMeetingKilledNM") >= 2 then
            npcUtil.giveKeyItem(player, tpz.ki.SANDORIAN_MARTIAL_ARTS_SCROLL)
            player:setCharVar("theFirstMeetingKilledNM", 0)
        elseif not GetMobByID(ID.mob.BILOPDOP):isSpawned() and not GetMobByID(ID.mob.DELOKNOK):isSpawned() then
            SpawnMob(ID.mob.BILOPDOP):updateClaim(player)
            SpawnMob(ID.mob.DELOKNOK):updateClaim(player)
        end

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.YOU_SEE_NOTHING)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
