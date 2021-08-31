-----------------------------------
-- Area: Windurst Walls
-- Door: House of the Hero
-- Involved in Mission 2-1
-- Involved In Quest: Know One's Onions, Onion Rings, The Puppet Master, Class Reunion
-- !pos -26 -13 260 239
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local thePuppetMaster = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER)
    local classReunion = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION)
    local carbuncleDebacle = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE)
    local iCanHearARainbow = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)

    -- LOST FOR WORDS
    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.LOST_FOR_WORDS and player:getMissionStatus(player:getNation()) == 5 then
        player:startEvent(337)

    -- KNOW ONE'S ONIONS
    elseif player:getCharVar("KnowOnesOnions") == 1 then
        player:startEvent(288, 0, 4387)

    -- ONION RINGS
    elseif player:getCharVar("OnionRings") == 1 then
        player:startEvent(289)

    -- WILD CARD
    elseif player:getCharVar("WildCard") == 1 then
        player:startEvent(386)
    elseif player:hasKeyItem(xi.ki.JOKER_CARD) then
        player:startEvent(387, 0, xi.ki.JOKER_CARD)

    -- I CAN HEAR A RAINBOW
    elseif iCanHearARainbow == QUEST_AVAILABLE and player:getMainLvl() >= 30 and player:hasItem(1125) then
        player:startEvent(384, 1125, 1125, 1125, 1125, 1125, 1125, 1125, 1125)
    elseif iCanHearARainbow == QUEST_ACCEPTED then
        player:startEvent(385, 1125, 1125, 1125, 1125, 1125, 1125, 1125, 1125)

    -- THE PUPPET MASTER (first time)
    elseif
        iCanHearARainbow == QUEST_COMPLETED and
        thePuppetMaster == QUEST_AVAILABLE and
        player:getMainLvl() >= xi.settings.AF1_QUEST_LEVEL and
        player:getMainJob() == xi.job.SMN
    then
        player:startEvent(402)
    elseif thePuppetMaster == QUEST_ACCEPTED and player:getCharVar("ThePuppetMasterProgress") == 1 then
        player:startEvent(403)

    -- CLASS REUNION
    elseif
        thePuppetMaster == QUEST_COMPLETED and
        classReunion == QUEST_AVAILABLE and
        player:getMainLvl() >= xi.settings.AF2_QUEST_LEVEL and
        player:getMainJob() == xi.job.SMN and
        not player:needToZone()
    then
        player:startEvent(413)

    -- CARBUNCLE DEBACLE
    elseif
        thePuppetMaster == QUEST_COMPLETED and
        classReunion == QUEST_COMPLETED and
        carbuncleDebacle == QUEST_AVAILABLE and
        player:getMainLvl() >= xi.settings.AF3_QUEST_LEVEL and
        player:getMainJob() == xi.job.SMN and
        not player:needToZone()
    then
        player:startEvent(415)

    -- THE PUPPET MASTER (repeat)
    elseif thePuppetMaster == QUEST_COMPLETED and not player:hasItem(17532) then
        player:startEvent(402)

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.DOORS_SEALED_SHUT)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- LOST FOR WORDS
    if csid == 337 then
        player:setMissionStatus(player:getNation(), 6)

    -- KNOW ONE'S ONIONS
    elseif csid == 288 then
        player:setCharVar("KnowOnesOnions", 2)

    -- ONION RINGS
    elseif csid == 289 and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.ONION_RINGS, {
        item = 17029,
        title = xi.title.STAR_ONION_BRIGADIER,
        fame = 10,
        var = {"OnionRingsTime", "OnionRings"}
    }) then
        player:delKeyItem(xi.ki.OLD_RING)

    -- WILD CARD
    elseif csid == 386 then
        player:setCharVar("WildCard", 2)
    elseif csid == 387 then
        player:delKeyItem(xi.ki.JOKER_CARD)
        npcUtil.giveCurrency(player, 'gil', 8000)

    -- I CAN HEAR A RAINBOW
    elseif csid == 384 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)

    -- THE PUPPET MASTER
    elseif csid == 402 then
        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER) == QUEST_COMPLETED then
            player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER)
        end
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER)
        player:setCharVar("ThePuppetMasterProgress", 1)

    -- CLASS REUNION
    elseif csid == 413 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION)
        npcUtil.giveKeyItem(player, xi.ki.CARBUNCLES_TEAR)
        player:setCharVar("ClassReunionProgress", 1)

    -- CARBUNCLE DEBACLE
    elseif csid == 415 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE)
        player:setCharVar("CarbuncleDebacleProgress", 1)
    end
end

return entity
