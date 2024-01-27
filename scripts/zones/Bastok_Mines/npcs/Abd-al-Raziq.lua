-----------------------------------
-- Area: Bastok Mines
--  NPC: Abd-al-Raziq
-- Type: Alchemy Guild Master
-- !pos 126.768 1.017 -0.234 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed  = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.ALCHEMY)

    if
        newRank > 9 and
        player:getCharVar('AlchemyExpertQuest') == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_ALCHEMIST)
    then
        if signed ~= 0 then
            player:setSkillRank(xi.skill.ALCHEMY, newRank)
            player:startEvent(121, 0, 0, 0, 0, newRank, 1)
            player:setCharVar('AlchemyExpertQuest', 0)
            player:setLocalVar('AlchemyTraded', 1)
        else
            player:startEvent(121, 0, 0, 0, 0, newRank, 0)
        end

    elseif newRank ~= 0 and newRank <= 9 then
        player:setSkillRank(xi.skill.ALCHEMY, newRank)
        player:startEvent(121, 0, 0, 0, 0, newRank)
        player:setLocalVar('AlchemyTraded', 1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill        = player:getSkillLevel(xi.skill.ALCHEMY)
    local testItem          = xi.crafting.getTestItem(player, npc, xi.skill.ALCHEMY)
    local guildMember       = xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) and 150995375 or 0
    local rankCap           = xi.crafting.getCraftSkillCap(player, xi.skill.ALCHEMY)
    local expertQuestStatus = 0
    local rank              = player:getSkillRank(xi.skill.ALCHEMY)
    local realSkill         = (craftSkill - rank) / 32
    local canRankUp         = rankCap - realSkill -- used to make sure rank up isn't overridden by ASA mission

    if xi.crafting.unionRepresentativeTriggerRenounceCheck(player, 120, realSkill, rankCap, 184549887) then
        return
    end

    if player:getCharVar('AlchemyExpertQuest') == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_ALCHEMIST) then
            expertQuestStatus = 640
        else
            expertQuestStatus = 600
        end
    end

    if
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD and
        guildMember == 150995375 and
        canRankUp >= 3
    then
        local item      = 0
        local asaStatus = player:getCharVar('ASA_Status')

        -- TODO: Other Enfeebling Kits
        if asaStatus == 0 then
            item = 2779
        else
            printf('Error: Unknown ASA Status Encountered <%u>', asaStatus)
        end

        -- The Parameters are Item IDs for the Recipe
        player:startEvent(590, item, 2774, 929, 4103, 2777, 4103)

    else
        player:startEvent(120, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    if
        csid == 120 and
        option >= xi.skill.WOODWORKING and
        option <= xi.skill.COOKING
    then
        xi.crafting.unionRepresentativeEventUpdateRenounce(player, option)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 120 and option == 2 then
        if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) then
            player:setCharVar('AlchemyExpertQuest', 1)
        end
    elseif csid == 120 and option == 1 then
        local crystal = 4101 -- water crystal

        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            xi.crafting.signupGuild(player, xi.crafting.guild.ALCHEMY)
        end
    else
        if player:getLocalVar('AlchemyTraded') == 1 then
            player:tradeComplete()
            player:setLocalVar('AlchemyTraded', 0)
        end
    end

    if player:hasEminenceRecord(106) then
        xi.roe.onRecordTrigger(player, 106)
    end
end

return entity
