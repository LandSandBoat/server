-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Torino-Samarino
-- Type: Quest NPC
--     Involved in Quests: Curses, Foiled A-Golem!?, Tuning Out
-- !pos 105 -20 140 111
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local FoiledAGolem = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.CURSES_FOILED_A_GOLEM)
    local tuningOutProgress = player:getCharVar("TuningOut_Progress")
    local copMission = player:getCurrentMission(COP)
    local copStatus = player:getCharVar("PromathiaStatus")

    -- QUEST: CURSES, FOILED A-GOLEM!?
    if player:hasKeyItem(tpz.ki.SHANTOTTOS_EXSPELL) and FoiledAGolem == QUEST_ACCEPTED then
        player:startEvent(108) -- key item taken, wait one game day for new spell
    elseif player:getCharVar("golemwait") == 1 and FoiledAGolem == QUEST_ACCEPTED then
        local gDay = VanadielDayOfTheYear()
        local gYear = VanadielYear()
        local dFinished = player:getCharVar("golemday")
        local yFinished = player:getCharVar("golemyear")
        if (gDay == dFinished and gYear == yFinished) then
            player:startEvent(113) -- re-write reminder
        elseif (gDay == dFinished + 1 and gYear == yFinished) then
            player:startEvent(109) -- re-write done
        end
    elseif FoiledAGolem == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL) then
            player:startEvent(105)
        elseif player:getCharVar("foiledagolemdeliverycomplete") == 1 then
            player:startEvent(110) -- talk to Shantotto reminder
        else
            player:startEvent(104) -- receive key item
        end

    -- QUEST: TUNING OUT
    elseif tuningOutProgress == 7 then
        player:startEvent(207) -- Ildy meets up with Rhinostery peers
    elseif tuningOutProgress == 8 then
        player:startEvent(208) -- Talks about Ildy being passionate about his work

    -- CoP 5-2: DESIRES OF EMPTINESS
    elseif copStatus > 8 and copMission == tpz.mission.id.cop.DESIRES_OF_EMPTINESS then
        player:startEvent(211)

    -- DEFAULT DIALOG
    else
        player:startEvent(101)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- QUEST: CURSES, FOILED A-GOLEM!?
    if csid == 104 and option == 1 then
        player:addKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SHANTOTTOS_NEW_SPELL)  -- add new spell key item
    elseif csid == 108 then                                       -- start wait for new scroll
        player:delKeyItem(tpz.ki.SHANTOTTOS_EXSPELL)
        player:setCharVar("golemday", VanadielDayOfTheYear())
        player:setCharVar("golemyear", VanadielYear())
        player:setCharVar("golemwait", 1)
    elseif csid == 109 then
        player:addKeyItem(tpz.ki.SHANTOTTOS_NEW_SPELL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SHANTOTTOS_NEW_SPELL)  -- add new spell key item
        player:setCharVar("golemday", 0)
        player:setCharVar("golemyear", 0)
        player:setCharVar("golemwait", 0)
    elseif csid == 207 then
        npcUtil.giveCurrency(player, "gil", 6000)
        player:setCharVar("TuningOut_Progress", 8)
    end
end

return entity
