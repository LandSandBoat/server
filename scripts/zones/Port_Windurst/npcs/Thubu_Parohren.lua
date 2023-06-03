-----------------------------------
-- Area: Port Windurst
--  NPC: Thubu Parohren
-- Type: Fishing Guild Master
-- !pos -182.230 -3.835 61.373 240
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.FISHING)

    if
        newRank > 9 and
        player:getCharVar("FishingExpertQuest") == 1 and
        player:hasKeyItem(xi.keyItem.ANGLERS_ALMANAC)
    then
        player:setSkillRank(xi.skill.FISHING, newRank)
        player:startEvent(10010, 0, 0, 0, 0, newRank)
        player:setCharVar("FishingExpertQuest", 0)
        player:setLocalVar("FishingTraded", 1)
    elseif newRank ~= 0 and newRank <= 9 then
        player:setSkillRank(xi.skill.FISHING, newRank)
        player:startEvent(10010, 0, 0, 0, 0, newRank)
        player:setLocalVar("FishingTraded", 1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill = player:getSkillLevel(xi.skill.FISHING)
    local testItem = xi.crafting.getTestItem(player, npc, xi.skill.FISHING)
    local guildMember = xi.crafting.hasJoinedGuild(player, xi.crafting.guild.FISHING) and 150995375 or 0
    local rankCap = xi.crafting.getCraftSkillCap(player, xi.skill.FISHING)
    local expertQuestStatus = 0
    local rank = player:getSkillRank(xi.skill.FISHING)
    local realSkill = (craftSkill - rank) / 32

    if player:getCharVar("FishingExpertQuest") == 1 then
        if player:hasKeyItem(xi.keyItem.ANGLERS_ALMANAC) then
            expertQuestStatus = 550
        else
            expertQuestStatus = 600
        end
    end

    if expertQuestStatus == 550 then
        --[[ TODO: This is resolved.  Replace with actual logic.
        Feeding the proper parameter currently hangs the client in cutscene. This may
        possibly be due to an unimplemented packet or function (display recipe?) Work
        around to present dialog to player to let them know the trade is ready to be
        received by triggering with lower rank up parameters.
        --]]
        player:showText(npc, 11807)
        player:showText(npc, 11809)
        player:startEvent(10009, testItem, realSkill, 44, guildMember, 0, 0, 0, 0)
    else
        player:startEvent(10009, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 10009  10010  595  597
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10009 and option == 2 then
        if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.FISHING) then
            player:setCharVar("FishingExpertQuest", 1)
        end
    elseif csid == 10009 and option == 1 then
        local crystal = 4101 -- water crystal

        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            xi.crafting.signupGuild(player, xi.crafting.guild.FISHING)
        end
    else
        if player:getLocalVar("FishingTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("FishingTraded", 0)
        end
    end
end

return entity
