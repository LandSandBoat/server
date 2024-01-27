-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Faulpie
-- Type: Leathercraft Guild Master
-- !pos -178.882 -2 9.891 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed  = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.LEATHERCRAFT)

    if
        newRank > 9 and
        player:getCharVar('LeathercraftExpertQuest') == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_TANNER)
    then
        if signed ~= 0 then
            player:setSkillRank(xi.skill.LEATHERCRAFT, newRank)
            player:startEvent(649, 0, 0, 0, 0, newRank, 1)
            player:setCharVar('LeathercraftExpertQuest', 0)
            player:setLocalVar('LeathercraftTraded', 1)
        else
            player:startEvent(649, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <= 9 then
        player:setSkillRank(xi.skill.LEATHERCRAFT, newRank)
        player:startEvent(649, 0, 0, 0, 0, newRank)
        player:setLocalVar('LeathercraftTraded', 1)
    end
end

entity.onTrigger = function(player, npc)
    local craftSkill        = player:getSkillLevel(xi.skill.LEATHERCRAFT)
    local testItem          = xi.crafting.getTestItem(player, npc, xi.skill.LEATHERCRAFT)
    local guildMember       = xi.crafting.hasJoinedGuild(player, xi.crafting.guild.LEATHERCRAFT) and 150995375 or 0
    local rankCap           = xi.crafting.getCraftSkillCap(player, xi.skill.LEATHERCRAFT)
    local expertQuestStatus = 0
    local rank              = player:getSkillRank(xi.skill.LEATHERCRAFT)
    local realSkill         = (craftSkill - rank) / 32
    local canRankUp         = rankCap - realSkill -- used to make sure rank up isn't overridden by ASA mission

    if xi.crafting.unionRepresentativeTriggerRenounceCheck(player, 648, realSkill, rankCap, 184549887) then
        return
    end

    if player:getCharVar('LeathercraftExpertQuest') == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_TANNER) then
            expertQuestStatus = 550
        else
            expertQuestStatus = 600
        end
    end

    if
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD and
        guildMember == 150995375 and
        canRankUp >= 3
    then
        local item = 0
        local asaStatus = player:getCharVar('ASA_Status')

        -- TODO: Other Enfeebling Kits
        if asaStatus == 0 then
            item = 2779
        else
            printf('Error: Unknown ASA Status Encountered <%u>', asaStatus)
        end

        -- The Parameters are Item IDs for the Recipe
        player:startEvent(944, item, 2773, 917, 917, 2776, 4103)
    else
        player:startEvent(648, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 648  649  760  761  762  763  764  765  770  771  772  773  774  775  944  914
entity.onEventUpdate = function(player, csid, option, npc)
    if
        csid == 648 and
        option >= xi.skill.WOODWORKING and
        option <= xi.skill.COOKING
    then
        xi.crafting.unionRepresentativeEventUpdateRenounce(player, option)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 648 and option == 2 then
        if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.LEATHERCRAFT) then
            player:setCharVar('LeathercraftExpertQuest', 1)
        end
    elseif csid == 648 and option == 1 then
        local crystal = 4103 -- dark crystal
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            xi.crafting.signupGuild(player, xi.crafting.guild.LEATHERCRAFT)
        end
    else
        if player:getLocalVar('LeathercraftTraded') == 1 then
            player:tradeComplete()
            player:setLocalVar('LeathercraftTraded', 0)
        end
    end

    if player:hasEminenceRecord(104) then
        xi.roe.onRecordTrigger(player, 104)
    end
end

return entity
