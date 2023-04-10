-----------------------------------
-- Area: Windurst Woods
--  NPC: Peshi Yohnts
-- Type: Bonecraft Guild Master
-- !pos -6.175 -6.249 -144.667 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/roe")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed  = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.BONECRAFT)

    if
        newRank > 9 and
        player:getCharVar("BonecraftExpertQuest") == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_BONEWORKER)
    then
        if signed ~= 0 then
            player:setSkillRank(xi.skill.BONECRAFT, newRank)
            player:startEvent(10017, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("BonecraftExpertQuest", 0)
            player:setLocalVar("BonecraftTraded", 1)
        else
            player:startEvent(10017, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <= 9 then
        player:setSkillRank(xi.skill.BONECRAFT, newRank)
        player:startEvent(10017, 0, 0, 0, 0, newRank)
        player:setLocalVar("BonecraftTraded", 1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill        = player:getSkillLevel(xi.skill.BONECRAFT)
    local testItem          = xi.crafting.getTestItem(player, npc, xi.skill.BONECRAFT)
    local guildMember       = xi.crafting.hasJoinedGuild(player, xi.crafting.guild.BONECRAFT) and 64 or 0
    local rankCap           = xi.crafting.getCraftSkillCap(player, xi.skill.BONECRAFT)
    local expertQuestStatus = 0
    local rank              = player:getSkillRank(xi.skill.BONECRAFT)
    local realSkill         = (craftSkill - rank) / 32

    if xi.crafting.unionRepresentativeTriggerRenounceCheck(player, 10016, realSkill, rankCap, 184549887) then
        return
    end

    if player:getCharVar("BonecraftExpertQuest") == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_BONEWORKER) then
            expertQuestStatus = 600
        else
            expertQuestStatus = 550
        end
    end

    player:startEvent(10016, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
end

-- 10016  10017  710  711  712  713  714  715  764
entity.onEventUpdate = function(player, csid, option)
    if
        csid == 10016 and
        option >= xi.skill.WOODWORKING and
        option <= xi.skill.COOKING
    then
        xi.crafting.unionRepresentativeEventUpdateRenounce(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10016 and option == 2 then
        if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.BONECRAFT) then
            player:setCharVar("BonecraftExpertQuest", 1)
        end
    elseif csid == 10016 and option == 1 then
        local crystal = 4098 -- wind crystal
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            xi.crafting.signupGuild(player, xi.crafting.guild.BONECRAFT)
        end
    else
        if player:getLocalVar("BonecraftTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("BonecraftTraded", 0)
        end
    end

    if player:hasEminenceRecord(105) then
        xi.roe.onRecordTrigger(player, 105)
    end
end

return entity
