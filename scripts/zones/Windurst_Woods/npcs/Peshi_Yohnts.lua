-----------------------------------
-- Area: Windurst Woods
--  NPC: Peshi Yohnts
-- Type: Bonecraft Guild Master
-- !pos -6.175 -6.249 -144.667 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local signed = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.BONECRAFT)

        if
        newRank > 9 and
        player:getCharVar("BonecraftExpertQuest") == 1 and
        player:hasKeyItem(tpz.keyItem.WAY_OF_THE_BONEWORKER)
    then
        if signed ~=0 then
            player:setSkillRank(tpz.skill.BONECRAFT, newRank)
            player:startEvent(10017, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("BonecraftExpertQuest",0)
            player:setLocalVar("BonecraftTraded",1)
        else
            player:startEvent(10017, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <=9 then
        player:setSkillRank(tpz.skill.BONECRAFT, newRank)
        player:startEvent(10017, 0, 0, 0, 0, newRank)
        player:setLocalVar("BonecraftTraded",1)
    end
end

function onTrigger(player, npc)
    local craftSkill = player:getSkillLevel(tpz.skill.BONECRAFT)
    local testItem = getTestItem(player, npc, tpz.skill.BONECRAFT)
    local guildMember = isGuildMember(player, 2)
    local rankCap = getCraftSkillCap(player, tpz.skill.BONECRAFT)
    local expertQuestStatus = 0
    local Rank = player:getSkillRank(tpz.skill.BONECRAFT)
    local realSkill = (craftSkill - Rank) / 32
    if guildMember == 1 then
        guildMember = 64
    end
    if player:getCharVar("BonecraftExpertQuest") == 1 then
        if player:hasKeyItem(tpz.keyItem.WAY_OF_THE_BONEWORKER) then
            expertQuestStatus = 600
        else
            expertQuestStatus = 550
        end
    end

    if expertQuestStatus == 600 then
        --[[  Feeding the proper parameter currently hangs the client in cutscene. This may
              possibly be due to an unimplemented packet or function (display recipe?) Work
              around to present dialog to player to let them know the trade is ready to be
              received by triggering with lower rank up parameters.  ]]--
        player:showText(npc, 7450)
        player:showText(npc, 7452)
        player:startEvent(10016, testItem, realSkill, 44, guildMember, 0, 0, 0, 0)
    else
        player:startEvent(10016, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 10016  10017  710  711  712  713  714  715  764
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local guildMember = isGuildMember(player, 2)

    if (csid == 10016 and option == 2) then
        if guildMember == 1 then
            player:setCharVar("BonecraftExpertQuest",1)
        end
    elseif (csid == 10016 and option == 1) then
        local crystal = 4098 -- wind crystal
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            signupGuild(player, guild.bonecraft)
        end
    else
        if player:getLocalVar("BonecraftTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("BonecraftTraded",0)
        end
    end
end
