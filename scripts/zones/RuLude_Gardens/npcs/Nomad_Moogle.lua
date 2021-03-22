-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Nomad Moogle
-- Type: Adventurer's Assistant
-- !pos 10.012 1.453 121.883 243
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local meritCount = player:getMeritCount()
    if (trade:hasItemQty(1127, 5) == true and trade:getGil() == 0 and trade:getItemCount() == 5 and meritCount > 2) then
        if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NEW_WORLDS_AWAIT) == QUEST_ACCEPTED) then
            player:startEvent(10135)
        end
    elseif (trade:hasItemQty(2955, 5) == true and trade:getGil() == 0 and trade:getItemCount() == 5 and meritCount > 3) then
        if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EXPANDING_HORIZONS) == QUEST_ACCEPTED) then
            player:startEvent(10136)
        end
    elseif (trade:hasItemQty(2955, 10) == true and trade:getGil() == 0 and trade:getItemCount() == 10 and meritCount > 4) then
        if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_STARS) == QUEST_ACCEPTED) then
            player:startEvent(10137)
        end
    elseif (trade:hasItemQty(2955, 1) == true and trade:hasItemQty(503, 1) == true and trade:getGil() == 0 and trade:getItemCount() == 2 and meritCount > 9) then
        if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED) == QUEST_ACCEPTED) then
            player:startEvent(10138)
        end
    elseif npcUtil.tradeHasExactly(trade, 3541) and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE) == QUEST_ACCEPTED then
        npcUtil.completeQuest(player, JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE) -- Exception to onEventFinish
        player:startEvent(10045, 0, 1, 5)
    elseif npcUtil.tradeHasExactly(trade, {{2956, 5}}) and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.SOUL_GEM_CLASP) then
        player:startEvent(10195, 1)
    end
end

entity.onTrigger = function(player, npc)
    if (player:hasKeyItem(xi.ki.LIMIT_BREAKER) == false and player:getMainLvl() >= 75) then
        player:startEvent(10045, 75, 2, 10, 7, 30, 302895, 4095)
    elseif (player:getMainLvl() == 75 and player:getLevelCap() == 75 and MAX_LEVEL >= 80 and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NEW_WORLDS_AWAIT) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 1, 0)
    elseif (player:getMainLvl() >= 76 and player:getLevelCap() == 80 and MAX_LEVEL >= 85 and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EXPANDING_HORIZONS) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 2, 0)
    elseif (player:getMainLvl() >= 81 and player:getLevelCap() == 85 and MAX_LEVEL >= 90 and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_STARS) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 3, 0)
    elseif (player:getMainLvl() >= 86 and player:getLevelCap() == 90 and MAX_LEVEL >= 95 and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 4, 0)
    elseif (player:getMainLvl() >= 91 and player:getLevelCap() == 95 and MAX_LEVEL == 99 and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE) == QUEST_AVAILABLE) then
        player:startEvent(10194)
    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE) == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_AVAILABLE and player:getLocalVar("MaybeAnotherTimeCS") == 1 then
        player:startEvent(10045, 0, 1, 5, 0, 1)
    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE) == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_AVAILABLE then
        player:startEvent(10045, 0, 1, 5)
    elseif player:hasKeyItem(tpz.ki.LIMIT_BREAKER) == true and player:hasKeyItem(tpz.ki.JOB_BREAKER) == false and player:getMainLvl() >= 99 then
        player:startEvent(10240, 0, 0, 0, 0)
    elseif player:getCharVar("BeyondInfinityCS") == 2 then
        player:startEvent(10139)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NEW_WORLDS_AWAIT) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 1, 1)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EXPANDING_HORIZONS) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 2, 1)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_STARS) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 3, 1)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 4, 1)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 6, 2)
    elseif  player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.SOUL_GEM_CLASP) then
        player:startEvent(10045, 0, 1, 5, 1)
    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED and player:getCharVar("BeyondInfinityCS") == 1 then
        if player:getMeritCount() >= 1 then
            player:startEvent(10045, 0, 1, 5, 3, 0, 0, 1)
        else
            player:startEvent(10045, 0, 1, 5, 3)
        end
    elseif (player:hasKeyItem(xi.ki.LIMIT_BREAKER) == true and player:getMainLvl() >= 75) then
        player:startEvent(10045, 0, 1, 0, 0)
    else
        player:startEvent(10045, 0, 2, 0, 0)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local meritCount = player:getMeritCount()

    if csid == 10045 then
        if option == 4 then
            player:addKeyItem(xi.ki.LIMIT_BREAKER)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIMIT_BREAKER)
        elseif option == 5 then
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NEW_WORLDS_AWAIT)
        elseif option == 7 then
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EXPANDING_HORIZONS)
        elseif option == 9 then
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_STARS)
        elseif option == 11 then
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED)

        -- PRELUDE TO PUISSANCE + BEYOND INFINITY
        elseif option == 15 then
            player:tradeComplete()
            player:setLocalVar("MaybeAnotherTimeCS", 1)
        elseif option == 13 then
            player:tradeComplete()
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)
            player:addKeyItem(xi.ki.SOUL_GEM_CLASP)
        elseif option == 14 then
            player:tradeComplete()
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)
            player:addKeyItem(xi.ki.SOUL_GEM_CLASP)
            player:setPos(-511.459, 159.004, -210.543, 10, 139) -- Horlais Peek
        elseif option == 19 then
            player:tradeComplete()
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)
            player:addKeyItem(xi.ki.SOUL_GEM_CLASP)
            player:setPos(-349.899, 104.213, -260.150, 0, 144) -- Waughrum Shrine
        elseif option == 20 then
            player:tradeComplete()
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)
            player:addKeyItem(xi.ki.SOUL_GEM_CLASP)
            player:setPos(299.316, -123.591, 353.760, 66, 146) -- Balga's Dais
        elseif option == 21 then
            player:tradeComplete()
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)
            player:addKeyItem(xi.ki.SOUL_GEM_CLASP)
            player:setPos(-225.146, -24.250, 20.057, 255, 206) -- Qu'bia Arena

        -- BEYOND INFINITY (Already holding keyitem)
        elseif option == 16 then -- Horlais Peek
            player:setPos(-511.459, 159.004, -210.543, 10, 139)
        elseif option == 22 then -- Waughrum Shrine
            player:setPos(-349.899, 104.213, -260.150, 0, 144)
        elseif option == 23 then -- Balga's Dais
            player:setPos(299.316, -123.591, 353.760, 66, 146)
        elseif option == 24 then -- Qu'bia Arena
            player:setPos(-225.146, -24.250, 20.057, 255, 206)

        -- BEYOND INFINITY (Trading merit for keyItem)
        elseif option == 17 then -- Horlais Peek
            npcUtil.giveKeyItem(player, xi.ki.SOUL_GEM_CLASP)
            player:setCharVar("BeyondInfinityCS", 0)
            player:setPos(-511.459, 159.004, -210.543, 10, 139)
        elseif option == 25 then -- Waughrum Shrine
            npcUtil.giveKeyItem(player, xi.ki.SOUL_GEM_CLASP)
            player:setCharVar("BeyondInfinityCS", 0)
            player:setPos(-349.899, 104.213, -260.150, 0, 144)
        elseif option == 26 then -- Balga's Dais
            npcUtil.giveKeyItem(player, xi.ki.SOUL_GEM_CLASP)
            player:setCharVar("BeyondInfinityCS", 0)
            player:setPos(299.316, -123.591, 353.760, 66, 146)
        elseif option == 27 then -- Qu'bia Arena
            npcUtil.giveKeyItem(player, xi.ki.SOUL_GEM_CLASP)
            player:setCharVar("BeyondInfinityCS", 0)
            player:setPos(-225.146, -24.250, 20.057, 255, 206)
        elseif option == 18 then -- Nowhere yet.
            player:setCharVar("BeyondInfinityCS", 0)
            npcUtil.giveKeyItem(player, xi.ki.SOUL_GEM_CLASP)
        end

    elseif csid == 10135 then
        player:tradeComplete()
        player:setMerits(meritCount - 3)
        player:addFame(JEUNO, 50)
        player:setLevelCap(80)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NEW_WORLDS_AWAIT)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_80)
    elseif csid == 10136 then
        player:tradeComplete()
        player:setMerits(meritCount - 4)
        player:addFame(JEUNO, 50)
        player:setLevelCap(85)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EXPANDING_HORIZONS)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_85)
    elseif csid == 10137 then
        player:tradeComplete()
        player:setMerits(meritCount - 5)
        player:startEvent(10161) -- this is the scene that is suppose to play and you are suppose to have to do correctly inorder to level cap increase to 90
        player:addFame(JEUNO, 50)
        player:setLevelCap(90)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_STARS)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_90)
    elseif csid == 10138 then
        player:tradeComplete()
        player:setMerits(meritCount - 10)
        player:addFame(JEUNO, 50)
        player:setLevelCap(95)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_95)
        player:addKeyItem(xi.ki.SOUL_GEM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SOUL_GEM)
    elseif csid == 10139 then
        npcUtil.completeQuest(player, JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY, {
            title = xi.title.BUSHIN_ASPIRANT,
            var = "BeyondInfinityCS"
        })
        player:setLevelCap(99)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_99)
    elseif csid == 10194 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE)

    -- BEYOND INFINITY (Trading kindred high crest for keitem)
    elseif csid == 10195 then
        player:tradeComplete()
        player:setCharVar("BeyondInfinityCS", 0)
        npcUtil.giveKeyItem(player, xi.ki.SOUL_GEM_CLASP)
        if option == 16 then -- Horlais Peek
            player:setPos(-511.459, 159.004, -210.543, 10, 139)
        elseif option == 22 then -- Waughrum Shrine
            player:setPos(-349.899, 104.213, -260.150, 0, 144)
        elseif option == 23 then -- Balga's Dais
            player:setPos(299.316, -123.591, 353.760, 66, 146)
        elseif option == 24 then -- Qu'bia Arena
            player:setPos(-225.146, -24.250, 20.057, 255, 206)
        end

    -- Job Breaker (Enables Capacity/Job Point Acquisition)
    elseif csid == 10240 and option == 28 then
        player:addKeyItem(xi.ki.JOB_BREAKER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.JOB_BREAKER)
    end
end

return entity
