-----------------------------------
-- Area: Windurst Waters
--  NPC: Piketo-Puketo
-- Type: Cooking Guild Master
-- !pos -124.012 -2.999 59.998 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/crafting")
require("scripts/globals/roe")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.COOKING)

    if
        newRank > 9 and
        player:getCharVar("CookingExpertQuest") == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_CULINARIAN)
    then
        if signed ~=0 then
            player:setSkillRank(xi.skill.COOKING, newRank)
            player:startEvent(10014, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("CookingExpertQuest",0)
            player:setLocalVar("CookingTraded",1)
        else
            player:startEvent(10014, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <=9 then
        player:setSkillRank(xi.skill.COOKING, newRank)
        player:startEvent(10014, 0, 0, 0, 0, newRank)
        player:setLocalVar("CookingTraded",1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill = player:getSkillLevel(xi.skill.COOKING)
    local testItem = xi.crafting.getTestItem(player, npc, xi.skill.COOKING)
    local guildMember = xi.crafting.isGuildMember(player, 4)
    local rankCap = xi.crafting.getCraftSkillCap(player, xi.skill.COOKING)
    local expertQuestStatus = 0
    local Rank = player:getSkillRank(xi.skill.COOKING)
    local realSkill = (craftSkill - Rank) / 32
    if (guildMember == 1) then guildMember = 150995375; end
    if player:getCharVar("CookingExpertQuest") == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_CULINARIAN) then
            expertQuestStatus = 550
        else
            expertQuestStatus = 600
        end
    end

    if expertQuestStatus == 550 then
        --[[
        Feeding the proper parameter currently hangs the client in cutscene. This may
        possibly be due to an unimplemented packet or function (display recipe?) Work
        around to present dialog to player to let them know the trade is ready to be
        received by triggering with lower rank up parameters.
        --]]
        player:showText(npc, 7260)
        player:showText(npc, 7262)
        player:startEvent(10013, testItem, realSkill, 44, guildMember, 0, 0, 0, 0)
    else
        player:startEvent(10013, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 978  983  980  981  10013  10014
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local guildMember = xi.crafting.isGuildMember(player, 4)

    if (csid == 10013 and option == 2) then
        if guildMember == 1 then
            player:setCharVar("CookingExpertQuest",1)
        end
    elseif (csid == 10013 and option == 1) then
        local crystal = 4096 -- fire crystal
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            xi.crafting.signupGuild(player, xi.crafting.guild.cooking)
        end
    else
        if player:getLocalVar("CookingTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("CookingTraded",0)
        end
    end

    if player:hasEminenceRecord(107) then
        xi.roe.onRecordTrigger(player, 107)
    end
end

return entity
