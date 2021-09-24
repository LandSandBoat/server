-----------------------------------
-- Area: Metalworks
--  NPC: Ghemp
-- Type: Smithing Guild Master
-- !pos -109 2 27 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/crafting")
require("scripts/globals/roe")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.SMITHING)

    if
        newRank > 9 and
        player:getCharVar("SmithingExpertQuest") == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_BLACKSMITH)
    then
        if signed ~=0 then
            player:setSkillRank(xi.skill.SMITHING, newRank)
            player:startEvent(102, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("SmithingExpertQuest",0)
            player:setLocalVar("SmithingTraded",1)
        else
            player:startEvent(102, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <=9 then
        player:setSkillRank(xi.skill.SMITHING, newRank)
        player:startEvent(102, 0, 0, 0, 0, newRank)
        player:setLocalVar("SmithingTraded",1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill = player:getSkillLevel(xi.skill.SMITHING)
    local testItem = xi.crafting.getTestItem(player, npc, xi.skill.SMITHING)
    local guildMember = xi.crafting.isGuildMember(player, 8)
    local rankCap = xi.crafting.getCraftSkillCap(player, xi.skill.SMITHING)
    local expertQuestStatus = 0
    local Rank = player:getSkillRank(xi.skill.SMITHING)
    local realSkill = (craftSkill - Rank) / 32
    if (guildMember == 1) then guildMember = 150995375; end

    if player:getCharVar("SmithingExpertQuest") == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_BLACKSMITH) then
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
        player:showText(npc, 6838)
        player:showText(npc, 6840)
        player:startEvent(101, testItem, realSkill, 44, guildMember, 0, 0, 0, 0)
    else
        player:startEvent(101, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 908  909  910  920  927  101  102
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local guildMember = xi.crafting.isGuildMember(player, 8)

    if (csid == 101 and option == 2) then
        if guildMember == 1 then
            player:setCharVar("SmithingExpertQuest",1)
        end
    elseif (csid == 101 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4096)
        else
            player:addItem(4096)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4096) -- Fire Crystal
            xi.crafting.signupGuild(player, xi.crafting.guild.smithing)
        end
    else
        if player:getLocalVar("SmithingTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("SmithingTraded",0)
        end
    end

    if player:hasEminenceRecord(101) then
        xi.roe.onRecordTrigger(player, 101)
    end
end

return entity
