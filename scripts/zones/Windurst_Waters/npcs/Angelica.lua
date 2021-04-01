-----------------------------------
-- Area: Windurst Waters
--  NPC: Angelica
-- Starts and Finished Quest: A Pose By Any Other Name
-- !pos -70 -10 -6 238
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local poseItems =
{
    [ xi.job.WAR] = 12576,
    [ xi.job.MNK] = 12600,
    [ xi.job.WHM] = 12608,
    [ xi.job.BLM] = 12608,
    [ xi.job.RDM] = 12608,
    [ xi.job.THF] = 12568,
    [ xi.job.PLD] = 12576,
    [ xi.job.DRK] = 12576,
    [ xi.job.BST] = 12568,
    [ xi.job.BRD] = 12600,
    [ xi.job.RNG] = 12568,
    [ xi.job.SAM] = 12584,
    [ xi.job.NIN] = 12584,
    [ xi.job.DRG] = 12576,
    [ xi.job.SMN] = 12608,
    [ xi.job.BLU] = 12600,
    [ xi.job.COR] = 12576,
    [ xi.job.PUP] = 12608,
    [ xi.job.DNC] = 12568,
    [ xi.job.SCH] = 12608,
    [ xi.job.GEO] = 12608,
    [ xi.job.RUN] = 12576,
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local aPose = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
    local aPoseProg = player:getCharVar("QuestAPoseByOtherName_prog")
    local desiredBody = poseItems[player:getMainJob()]
    local currentBody = player:getEquipID(xi.slot.BODY)

    -- pre-quest CS
    if aPose == QUEST_AVAILABLE and aPoseProg == 0 and not player:needToZone() and currentBody ~= desiredBody then
        player:startEvent(87) -- pre-quest CS

    -- start quest
    elseif aPose == QUEST_AVAILABLE and aPoseProg == 1 and currentBody ~= desiredBody then
        player:startEvent(92, 0, 0, 0, desiredBody)

    -- check in during quest
    elseif aPose == QUEST_ACCEPTED then
        local starttime = player:getCharVar("QuestAPoseByOtherName_time")
        if os.time() - starttime < 600 then -- took less than 10 minutes
            if currentBody == player:getCharVar("QuestAPoseByOtherName_equip") then
                player:startEvent(96) -- complete quest
            else
                player:startEvent(93, 0, desiredBody, 0, player:getCharVar("QuestAPoseByOtherName_equip")) -- reminder
            end
        else
            player:startEvent(102) -- fail quest
        end

    -- post-quest dialog
    elseif aPose == QUEST_COMPLETED and player:needToZone() then
        player:startEvent(101)

    -- default dialogs
    else
        local rand = math.random(1, 3)
        if rand == 1 then
            player:startEvent(86)
        elseif rand == 2 then
            player:startEvent(88)
        else
            player:startEvent(89)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- pre-quest CS
    if csid == 87 then
        player:setCharVar("QuestAPoseByOtherName_prog", 1)

    -- start quest
    elseif csid == 92 then
        local desiredBody = poseItems[player:getMainJob()]

        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
        player:setCharVar("QuestAPoseByOtherName_time", os.time())
        player:setCharVar("QuestAPoseByOtherName_prog", 2)
        player:setCharVar("QuestAPoseByOtherName_equip", desiredBody)

    -- complete quest
    elseif csid == 96 and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME, {
        item = 206, -- copy_of_ancient_blood
        ki = xi.ki.ANGELICAS_AUTOGRAPH,
        fame = 75,
        title = xi.title.SUPER_MODEL,
        var = {"QuestAPoseByOtherName_time", "QuestAPoseByOtherName_equip", "QuestAPoseByOtherName_prog"},
    }) then
        player:needToZone(true)

    -- fail quest
    elseif csid == 102 then
        player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
        player:addTitle(xi.title.LOWER_THAN_THE_LOWEST_TUNNEL_WORM)
        player:setCharVar("QuestAPoseByOtherName_time", 0)
        player:setCharVar("QuestAPoseByOtherName_equip", 0)
        player:setCharVar("QuestAPoseByOtherName_prog", 0)
        player:needToZone(true)
    end
end

return entity
