-----------------------------------
-- Area: Windurst Woods
--  NPC: Ponono
-- Type: Clothcraft Guild Master
-- !pos -38.243 -2.25 -120.954 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local signed = player:signedByTrader(player,0)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.CLOTHCRAFT)

    if
        newRank > 9 and
        player:getCharVar("ClothcraftExpertQuest") == 1 and
        player:hasKeyItem(tpz.keyItem.WAY_OF_THE_WEAVER)
    then
        if signed ~=0 then
            player:setSkillRank(tpz.skill.CLOTHCRAFT, newRank)
            player:startEvent(10012, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("ClothcraftExpertQuest",2)
        else
            player:startEvent(10012, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <=9 then
        player:setSkillRank(tpz.skill.CLOTHCRAFT, newRank)
        player:startEvent(10012, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local craftSkill = player:getSkillLevel(tpz.skill.CLOTHCRAFT)
    local testItem = getTestItem(player, npc, tpz.skill.CLOTHCRAFT)
    local guildMember = isGuildMember(player, 3)
    local rankCap = getCraftSkillCap(player, tpz.skill.CLOTHCRAFT)
    local expertQuestStatus = 0
    local Rank = player:getSkillRank(tpz.skill.CLOTHCRAFT)
    local realSkill = (craftSkill - Rank) / 32
    if guildMember == 1 then guildMember = 10000; end
    if player:getCharVar("ClothcraftExpertQuest") == 1 then
        if player:hasKeyItem(tpz.keyItem.WAY_OF_THE_WEAVER) then
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
        player:showText(npc, 7339)
        player:showText(npc, 7341)
        player:startEvent(10011, testItem, realSkill, 44, guildMember, 0, 0, 0, 0)
    else
        player:startEvent(10011, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 10011  10012  700  701  702  703  704  705  832  765
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local guildMember = isGuildMember(player, 3)

    if (csid == 10011 and option == 2) then
        if guildMember == 1 then
            player:setCharVar("ClothcraftExpertQuest",1)
        end
    elseif (csid == 10011 and option == 1) then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4099)
        else
            player:addItem(4099) -- earth crystal
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4099)
            signupGuild(player, guild.clothcraft)
        end
    end
end
