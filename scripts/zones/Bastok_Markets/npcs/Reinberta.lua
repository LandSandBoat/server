-----------------------------------
-- Area: Bastok Markets
--  NPC: Reinberta
-- Type: Goldsmithing Guild Master
-- !pos -190.605 -7.814 -59.432 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local signed = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.GOLDSMITHING)

    if
        newRank > 9 and
        player:getCharVar("GoldsmithingExpertQuest") == 1 and
        player:hasKeyItem(tpz.keyItem.WAY_OF_THE_GOLDSMITH)
    then
        if signed ~=0 then
            player:setSkillRank(tpz.skill.GOLDSMITHING, newRank)
            player:startEvent(301, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("GoldsmithingExpertQuest",0)
            player:setLocalVar("GoldsmithingTraded",1)
        else
            player:startEvent(301, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <=9 then
        player:setSkillRank(tpz.skill.GOLDSMITHING, newRank)
        player:startEvent(301, 0, 0, 0, 0, newRank)
        player:setLocalVar("GoldsmithingTraded",1)
    end
end

function onTrigger(player, npc)
    local craftSkill = player:getSkillLevel(tpz.skill.GOLDSMITHING)
    local testItem = getTestItem(player, npc, tpz.skill.GOLDSMITHING)
    local guildMember = isGuildMember(player, 6)
        local rankCap = getCraftSkillCap(player, tpz.skill.GOLDSMITHING)
    local expertQuestStatus = 0
    local Rank = player:getSkillRank(tpz.skill.GOLDSMITHING)
    local realSkill = (craftSkill - Rank) / 32
    if (guildMember == 1) then guildMember = 150995375; end
    if player:getCharVar("GoldsmithingExpertQuest") == 1 then
        if player:hasKeyItem(tpz.keyItem.WAY_OF_THE_GOLDSMITH) then
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
        player:showText(npc, 7188)
        player:showText(npc, 7190)
        player:startEvent(300, testItem, realSkill, 44, guildMember, 0, 0, 0, 0)
    else
        player:startEvent(300, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 300  301  402
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local guildMember = isGuildMember(player, 6)

    if (csid == 300 and option == 2) then
        if guildMember == 1 then
            player:setCharVar("GoldsmithingExpertQuest",1)
        end
    elseif (csid == 300 and option == 1) then
        local crystal = 4096 -- fire crystal
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            signupGuild(player, guild.goldsmithing)
        end
    else
        if player:getLocalVar("GoldsmithingTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("GoldsmithingTraded",0)
        end
    end
end
