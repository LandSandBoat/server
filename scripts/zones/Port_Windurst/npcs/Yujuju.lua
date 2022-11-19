-----------------------------------
-- Area: Port Windurst
--  NPC: Yujuju
--  Involved In Quest: Making Headlines
-- !pos 201.523 -4.785 138.978 240
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local makingHeadlines = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_HEADLINES)
    local wildcatWindurst = player:getCharVar("WildcatWindurst")

    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 19)
    then
        player:startEvent(621)
    elseif makingHeadlines == QUEST_ACCEPTED then
        -- bitmask of progress: 0 = Kyume-Romeh, 1 = Yuyuju, 2 = Hiwom-Gomoi, 3 = Umumu, 4 = Mahogany Door
        local prog = player:getCharVar("QuestMakingHeadlines_var")

        if not utils.mask.getBit(prog, 1) then
            player:startEvent(314) -- Get Scoop
        else
            player:startEvent(315) -- After receiving scoop
        end
    else
        player:startEvent(340) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 314 then
        npcUtil.giveKeyItem(player, xi.ki.PORT_WINDURST_SCOOP)
        player:setCharVar("QuestMakingHeadlines_var", utils.mask.setBit(player:getCharVar("QuestMakingHeadlines_var"), 1, true))
    elseif csid == 621 then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 19, true))
    end
end

return entity
