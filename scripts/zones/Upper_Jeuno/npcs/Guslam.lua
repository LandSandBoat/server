-----------------------------------
-- Area: Upper Jeuno
--  NPC: Guslam
-- Starts Quest: Borghertz's Hands (AF Hands, Many job)
-- !pos -5 1 48 244
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

-----------------------------------
-- If it's the first Hands quest
-----------------------------------

function nbHandsQuestsCompleted(player)

    local questNotAvailable = 0

    for nb = 0, 14, 1 do
        if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + nb) ~= QUEST_AVAILABLE) then
            questNotAvailable = questNotAvailable + 1
        end
    end

    return questNotAvailable

end

function onTrigger(player, npc)

    if (player:getMainLvl() >= 50 and player:getCharVar("BorghertzAlreadyActiveWithJob") == 0) then
        if (player:getMainJob() == tpz.job.WAR and
           player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH) ~= QUEST_AVAILABLE and
           player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for WAR
        elseif (player:getMainJob() == tpz.job.MNK and
               player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_FIRST_MEETING) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_STRIKING_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for MNK
        elseif (player:getMainJob() == tpz.job.WHM and
               player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_HEALING_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for WHM
        elseif (player:getMainJob() == tpz.job.BLM and
               player:getQuestStatus(WINDURST, tpz.quest.id.windurst.RECOLLECTIONS) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_SORCEROUS_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for BLM
        elseif (player:getMainJob() == tpz.job.RDM and
               player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_VERMILLION_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for RDM
        elseif (player:getMainJob() == tpz.job.THF and
               player:getQuestStatus(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_SNEAKY_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for THF
        elseif (player:getMainJob() == tpz.job.PLD and
               player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_BOY_S_DREAM) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_STALWART_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for PLD
        elseif (player:getMainJob() == tpz.job.DRK and
               player:getQuestStatus(BASTOK, tpz.quest.id.bastok.DARK_PUPPET) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_SHADOWY_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for DRK
        elseif (player:getMainJob() == tpz.job.BST and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SCATTERED_INTO_SHADOW) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_WILD_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for BST
        elseif (player:getMainJob() == tpz.job.BRD and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_REQUIEM) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_HARMONIOUS_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for BRD
        elseif (player:getMainJob() == tpz.job.RNG and
               player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FIRE_AND_BRIMSTONE) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_CHASING_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for RNG
        elseif (player:getMainJob() == tpz.job.SAM and
               player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.YOMI_OKURI) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_LOYAL_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for SAM
        elseif (player:getMainJob() == tpz.job.NIN and
               player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_LURKING_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for NIN
        elseif (player:getMainJob() == tpz.job.DRG and
               player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.CHASING_QUOTAS) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_DRAGON_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for DRG
        elseif (player:getMainJob() == tpz.job.SMN and
               player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CLASS_REUNION) ~= QUEST_AVAILABLE and
               player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_CALLING_HANDS) == QUEST_AVAILABLE) then
            player:startEvent(155) -- Start Quest for SMN
        else
            player:startEvent(154) -- Standard dialog
        end
    elseif (player:getCharVar("BorghertzAlreadyActiveWithJob") >= 1 and player:hasKeyItem(tpz.ki.OLD_GAUNTLETS) == false) then
        player:startEvent(43) -- During Quest before KI obtained
    elseif (player:hasKeyItem(tpz.ki.OLD_GAUNTLETS) == true) then
        player:startEvent(26) -- Dialog with Old Gauntlets KI

        if (nbHandsQuestsCompleted(player) == 1) then
            player:setCharVar("BorghertzHandsFirstTime", 1)
        else
            player:setCharVar("BorghertzCS", 1)
        end
    else
        player:startEvent(154) -- Standard dialog
    end

end

-- 154 Standard dialog
-- 155 Start Quest
-- 43 During Quest before KI obtained
-- 26 Dialog avec Old Gauntlets KI
-- 156 During Quest after Old Gauntlets KI ?
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 155) then
        local NumQuest = tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + player:getMainJob() - 1
        player:addQuest(JEUNO, NumQuest)
        player:setCharVar("BorghertzAlreadyActiveWithJob", player:getMainJob())
    end

end
