-----------------------------------
-- Area: Bastok Markets
--  NPC: Reinberta
-- Type: Goldsmithing Guild Master
-- !pos -190.605 -7.814 -59.432 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/crafting")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.GOLDSMITHING)

    if
        newRank > 9 and
        player:getCharVar("GoldsmithingExpertQuest") == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_GOLDSMITH)
    then
        if signed ~= 0 then
            player:setSkillRank(xi.skill.GOLDSMITHING, newRank)
            player:startEvent(301, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("GoldsmithingExpertQuest", 0)
            player:setLocalVar("GoldsmithingTraded", 1)
        else
            player:startEvent(301, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <= 9 then
        player:setSkillRank(xi.skill.GOLDSMITHING, newRank)
        player:startEvent(301, 0, 0, 0, 0, newRank)
        player:setLocalVar("GoldsmithingTraded", 1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill  = player:getSkillLevel(xi.skill.GOLDSMITHING)
    local testItem    = xi.crafting.getTestItem(player, npc, xi.skill.GOLDSMITHING)
    local guildMember = xi.crafting.hasJoinedGuild(player, xi.crafting.guild.GOLDSMITHING) and 150995375 or 0
    local rankCap     = xi.crafting.getCraftSkillCap(player, xi.skill.GOLDSMITHING)
    local rank        = player:getSkillRank(xi.skill.GOLDSMITHING)
    local realSkill   = (craftSkill - rank) / 32
    local expertQuestStatus = 0

    if xi.crafting.unionRepresentativeTriggerRenounceCheck(player, 300, realSkill, rankCap, 184549887) then
        return
    end

    if player:getCharVar("GoldsmithingExpertQuest") == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_GOLDSMITH) then
            expertQuestStatus = 600
        else
            expertQuestStatus = 550
        end
    end

    player:startEvent(300, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option)
    if
        csid == 300 and
        option >= xi.skill.WOODWORKING and
        option <= xi.skill.COOKING
    then
        xi.crafting.unionRepresentativeEventUpdateRenounce(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 300 and option == 2 then
        if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.GOLDSMITHING) then
            player:setCharVar("GoldsmithingExpertQuest", 1)
        end
    elseif csid == 300 and option == 1 then
        local crystal = 4096 -- fire crystal
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            xi.crafting.signupGuild(player, xi.crafting.guild.GOLDSMITHING)
        end
    else
        if player:getLocalVar("GoldsmithingTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("GoldsmithingTraded", 0)
        end
    end

    if player:hasEminenceRecord(102) then
        xi.roe.onRecordTrigger(player, 102)
    end
end

return entity
