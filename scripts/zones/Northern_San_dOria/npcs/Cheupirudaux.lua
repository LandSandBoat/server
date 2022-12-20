-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Cheupirudaux
-- Type: Woodworking Guildmaster NPC
-- Involved in Quest: It's Raining Mannequins!
-- !pos -138 12 250 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/crafting")
require("scripts/globals/roe")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed  = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.WOODWORKING)

    if
        newRank > 9 and
        player:getCharVar("WoodworkingExpertQuest") == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_CARPENTER)
    then
        if signed ~= 0 then
            player:setSkillRank(xi.skill.WOODWORKING, newRank)
            player:startEvent(622, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("WoodworkingExpertQuest", 0)
            player:setLocalVar("WoodworkingTraded", 1)
        else
            player:startEvent(622, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <= 9 then
        player:setSkillRank(xi.skill.WOODWORKING, newRank)
        player:startEvent(622, 0, 0, 0, 0, newRank)
        player:setLocalVar("WoodworkingTraded", 1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill        = player:getSkillLevel(xi.skill.WOODWORKING)
    local testItem          = xi.crafting.getTestItem(player, npc, xi.skill.WOODWORKING)
    local guildMember       = xi.crafting.hasJoinedGuild(player, xi.crafting.guild.WOODWORKING) and 150995375 or 0
    local rankCap           = xi.crafting.getCraftSkillCap(player, xi.skill.WOODWORKING)
    local expertQuestStatus = 0
    local rank              = player:getSkillRank(xi.skill.WOODWORKING)
    local realSkill         = (craftSkill - rank) / 32

    if xi.crafting.unionRepresentativeTriggerRenounceCheck(player, 621, realSkill, rankCap, 184549887) then
        return
    end

    if player:getCharVar("WoodworkingExpertQuest") == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_CARPENTER) then
            expertQuestStatus = 550
        else
            expertQuestStatus = 600
        end
    end

    player:startEvent(621, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
end

-- 621  622  759  16  0
entity.onEventUpdate = function(player, csid, option)
    if
        csid == 621 and
        option >= xi.skill.WOODWORKING and
        option <= xi.skill.COOKING
    then
        xi.crafting.unionRepresentativeEventUpdateRenounce(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 621 and option == 2 then
        if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.WOODWORKING) then
            player:setCharVar("WoodworkingExpertQuest", 1)
        end
    elseif csid == 621 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4098)
        else
            player:addItem(4098)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4098) -- Wind Crystal
            xi.crafting.signupGuild(player, xi.crafting.guild.WOODWORKING)
        end
    elseif csid == 621 and option > 900 then
        player:resetLocalVars()
    else
        if player:getLocalVar("WoodworkingTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("WoodworkingTraded", 0)
        end
    end

    if player:hasEminenceRecord(100) then
        xi.roe.onRecordTrigger(player, 100)
    end
end

return entity
