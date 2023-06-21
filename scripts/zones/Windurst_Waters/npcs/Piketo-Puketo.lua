-----------------------------------
-- Area: Windurst Waters
--  NPC: Piketo-Puketo
-- Type: Cooking Guild Master
-- !pos -124.012 -2.999 59.998 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/crafting")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed  = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.COOKING)

    if
        newRank > 9 and
        player:getCharVar("CookingExpertQuest") == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_CULINARIAN)
    then
        if signed ~= 0 then
            player:setSkillRank(xi.skill.COOKING, newRank)
            player:startEvent(10014, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("CookingExpertQuest", 0)
            player:setLocalVar("CookingTraded", 1)
        else
            player:startEvent(10014, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <= 9 then
        player:setSkillRank(xi.skill.COOKING, newRank)
        player:startEvent(10014, 0, 0, 0, 0, newRank)
        player:setLocalVar("CookingTraded", 1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill        = player:getSkillLevel(xi.skill.COOKING)
    local testItem          = xi.crafting.getTestItem(player, npc, xi.skill.COOKING)
    local guildMember       = xi.crafting.hasJoinedGuild(player, xi.crafting.guild.COOKING) and 150995375 or 0
    local rankCap           = xi.crafting.getCraftSkillCap(player, xi.skill.COOKING)
    local expertQuestStatus = 0
    local rank              = player:getSkillRank(xi.skill.COOKING)
    local realSkill         = (craftSkill - rank) / 32

    if xi.crafting.unionRepresentativeTriggerRenounceCheck(player, 10013, realSkill, rankCap, 184549887) then
        return
    end

    if player:getCharVar("CookingExpertQuest") == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_CULINARIAN) then
            expertQuestStatus = 768
        else
            expertQuestStatus = 512
        end
    end

    player:startEvent(10013, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
end

-- 978  983  980  981  10013  10014
entity.onEventUpdate = function(player, csid, option)
    if
        csid == 10013 and
        option >= xi.skill.WOODWORKING and
        option <= xi.skill.COOKING
    then
        xi.crafting.unionRepresentativeEventUpdateRenounce(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10013 and option == 2 then
        if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.COOKING) then
            player:setCharVar("CookingExpertQuest", 1)
        end
    elseif csid == 10013 and option == 1 then
        local crystal = 4096 -- fire crystal
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            xi.crafting.signupGuild(player, xi.crafting.guild.COOKING)
        end
    else
        if player:getLocalVar("CookingTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("CookingTraded", 0)
        end
    end

    if player:hasEminenceRecord(107) then
        xi.roe.onRecordTrigger(player, 107)
    end
end

return entity
