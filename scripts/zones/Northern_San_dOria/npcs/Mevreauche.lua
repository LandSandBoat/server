-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Mevreauche
-- Type: Smithing Guild Master
-- !pos -193.584 10 148.655 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local signed = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.SMITHING)

    if
        newRank > 9 and
        player:getCharVar("SmithingExpertQuest") == 1 and
        player:hasKeyItem(tpz.keyItem.WAY_OF_THE_BLACKSMITH)
    then
        if signed ~=0 then
            player:setSkillRank(tpz.skill.SMITHING, newRank)
            player:startEvent(627, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("SmithingExpertQuest",0)
            player:setLocalVar("SmithingTraded",1)
        else
            player:startEvent(627, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <=9 then
        player:setSkillRank(tpz.skill.SMITHING, newRank)
        player:startEvent(627, 0, 0, 0, 0, newRank)
        player:setLocalVar("SmithingTraded",1)
    end
end

function onTrigger(player, npc)
    local craftSkill = player:getSkillLevel(tpz.skill.SMITHING)
    local testItem = getTestItem(player, npc, tpz.skill.SMITHING)
    local guildMember = isGuildMember(player, 8)
    local rankCap = getCraftSkillCap(player, tpz.skill.SMITHING)
    local expertQuestStatus = 0
    local Rank = player:getSkillRank(tpz.skill.SMITHING)
    local realSkill = (craftSkill - Rank) / 32
    if (guildMember == 1) then guildMember = 150995375; end

    if player:getCharVar("SmithingExpertQuest") == 1 then
        if player:hasKeyItem(tpz.keyItem.WAY_OF_THE_BLACKSMITH) then
            expertQuestStatus = 550
        else
            expertQuestStatus = 600
        end
    end

    if expertQuestStatus == 550 then
        --[[  Feeding the proper parameter currently hangs the client in cutscene. This may
              possibly be due to an unimplemented packet or function (display recipe?) Work
              around to present dialog to player to let them know the trade is ready to be
              received by triggering with lower rank up parameters.  ]]--
        player:showText(npc, 7138)
        player:showText(npc, 7140)
        player:startEvent(626, testItem, realSkill, 44, guildMember, 0, 0, 0, 0)
    else
        player:startEvent(626, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 626  627  16  0  73  74
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local guildMember = isGuildMember(player, 8)

    if (csid == 626 and option == 2) then
        if guildMember == 1 then
            player:setCharVar("SmithingExpertQuest",1)
        end
    elseif (csid == 626 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4096)
        else
            player:addItem(4096)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4096) -- Fire Crystal
            signupGuild(player, guild.smithing)
        end
    else
        if player:getLocalVar("SmithingTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("SmithingTraded",0)
        end
    end
end
