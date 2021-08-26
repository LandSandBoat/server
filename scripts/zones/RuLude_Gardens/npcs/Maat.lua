-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Maat
-- Starts and Finishes Quest: Limit Break Quest 1-5
-- Involved in Quests: Beat Around the Bushin
-- !pos 8 3 118 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local tradeCount = trade:getItemCount()

    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) ~= QUEST_AVAILABLE and player:getMainLvl() >= 66 and player:getCharVar("maatsCap") < 1 then
        local mJob = player:getMainJob()
        if trade:hasItemQty(1425 + mJob, 1) and tradeCount == 1 and mJob <= 15 then
            player:startEvent(64, mJob) -- Teleport to battlefield for "Shattering Stars"
        end
    end

end

entity.onTrigger = function(player, npc)
    local LvL = player:getMainLvl()
    local mJob = player:getMainJob()
    local shatteringStars = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)

    if player:getCharVar("BeatAroundTheBushin") == 5 then
        player:startEvent(117)

    elseif shatteringStars == QUEST_AVAILABLE and LvL >= 66 and mJob <= 15 and player:getLevelCap() == 70 and xi.settings.MAX_LEVEL >= 75 then
        player:startEvent(92, player:getMainJob()) -- Start Quest "Shattering Stars"

    elseif shatteringStars == QUEST_ACCEPTED and LvL >= 66 and mJob <= 15 and player:getCharVar("maatDefeated") == 0 then
        player:startEvent(91, player:getMainJob()) -- During Quest "Shattering Stars"

    elseif shatteringStars == QUEST_ACCEPTED and LvL >= 66 and mJob <= 15 and player:getCharVar("maatDefeated") >= 1 then
        player:startEvent(93) -- Finish Quest "Shattering Stars"

    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_SUN) == QUEST_AVAILABLE and
        mJob <= 15 and
        utils.mask.isFull(player:getCharVar("maatsCap"), 15) -- defeated maat on 15 jobs
    then
        player:startEvent(74) -- Finish Quest "Beyond The Sun"

    else
        player:showText(npc, ID.text.MAAT_DIALOG)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 117 then
        player:setCharVar("BeatAroundTheBushin", 6)

    elseif csid == 92 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)

    elseif csid == 64 and option == 1 then
        local mJob = player:getMainJob()
        if mJob == xi.job.MNK or mJob == xi.job.WHM or mJob == xi.job.SMN then
            player:setPos(299.316, -123.591, 353.760, 66, 146)
        elseif mJob == xi.job.WAR or mJob == xi.job.BLM or mJob == xi.job.RNG then
            player:setPos(-511.459, 159.004, -210.543, 10, 139)
        elseif mJob == xi.job.PLD or mJob == xi.job.DRK or mJob == xi.job.BRD then
            player:setPos(-225.146, -24.250, 20.057, 255, 206)
        elseif mJob == xi.job.RDM or mJob == xi.job.THF or mJob == xi.job.BST then
            player:setPos(-349.899, 104.213, -260.150, 0, 144)
        elseif mJob == xi.job.SAM or mJob == xi.job.NIN or mJob == xi.job.DRG then
            player:setPos(-220.084, -0.645, 4.442, 191, 168)
        end

    elseif csid == 93 then
        player:addTitle(xi.title.STAR_BREAKER)
        player:setLevelCap(75)
        player:setCharVar("maatDefeated", 0)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_75)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)
        player:addFame(JEUNO, 80)

    elseif csid == 74 then
        if player:getFreeSlotsCount() > 0 then
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_SUN)
            player:addTitle(xi.title.ULTIMATE_CHAMPION_OF_THE_WORLD)
            player:setCharVar("maatsCap", 0)
            player:addItem(15194)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 15194)
        end
    end
end

return entity
