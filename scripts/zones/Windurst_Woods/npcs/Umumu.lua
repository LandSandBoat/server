-----------------------------------
-- Area: Windurst Woods
--  NPC: Umumu
--  Involved In Quest: Making Headlines
-- !pos 32.575 -5.250 141.372 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end

    local MakingHeadlines = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatWindurst, 3) then
        player:startEvent(731)
    elseif MakingHeadlines == QUEST_ACCEPTED then
        local prog = player:getCharVar("QuestMakingHeadlines_var")
        -- Variable to track if player has talked to 4 NPCs and a door
        -- 1 = Kyume
        -- 2 = Yujuju
        -- 4 = Hiwom
        -- 8 = Umumu
        -- 16 = Mahogany Door
        if testflag(tonumber(prog), 16) then
            player:startEvent(383) -- Advised to go to Naiko
        elseif not testflag(tonumber(prog), 8) then
            player:startEvent(381) -- Get scoop and asked to validate
        else
            player:startEvent(382) -- Reminded to validate
        end
    elseif MakingHeadlines == QUEST_COMPLETED then
        local rand = math.random(1, 3)

        if rand == 1 then
            player:startEvent(385) -- Conversation after quest completed
        elseif rand == 2 then
            player:startEvent(386) -- Conversation after quest completed
        elseif rand == 3 then
            player:startEvent(414) -- Standard Conversation
        end
    else
        player:startEvent(414) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 381 then
        local prog = player:getCharVar("QuestMakingHeadlines_var")
        player:addKeyItem(tpz.ki.WINDURST_WOODS_SCOOP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WINDURST_WOODS_SCOOP)
        player:setCharVar("QuestMakingHeadlines_var", prog+8)
    elseif csid == 731 then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 3, true))
    end
end

return entity
