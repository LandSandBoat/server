-----------------------------------
-- Steamed Rams
-----------------------------------
-- !addquest 7 9
-- Randecque   : !pos 61 -6 137 164
-- Mainchelite : !pos -16 1 -30 80
-- qm3         : !pos 312.821 -30.495 -67.15
-- qm4         : !pos 541.425 -49.83 178.563
-- qm5         : !pos 380.015 -26.5 -22.525
-----------------------------------
local southernSandoriaSID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS)

quest.reward =
{
    title = xi.title.KNIGHT_OF_THE_IRON_RAM,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.GARLAIGE_CITADEL_S] =
        {
            ['Randecque'] =
            {
                onTrigger = function(player, npc)
                    if player:getCampaignAllegiance() > 0 then
                        return quest:event(12)
                    elseif not player:hasKeyItem(xi.ki.RED_RECOMMENDATION_LETTER) then
                        local hasDeclined = quest:getVar(player, 'Option')

                        return quest:progressEvent(1, { [7] = hasDeclined })
                    else
                        return quest:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.RED_RECOMMENDATION_LETTER)
                        quest:setVar(player, 'Option', 0)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Mainchelite'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == QUEST_ACCEPTED or
                        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS) == QUEST_ACCEPTED
                    then
                        return quest:event(9)
                    elseif
                        player:hasKeyItem(xi.ki.RED_RECOMMENDATION_LETTER) or
                        player:getCampaignAllegiance() > 0
                    then
                        local hasDeclined = quest:getVar(player, 'Option')
                        local isPledged   = player:getCampaignAllegiance() > 0 and 3 or 0

                        return quest:progressEvent(7 + isPledged + hasDeclined)
                    else
                        return quest:event(15)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        player:delKeyItem(xi.ki.RED_RECOMMENDATION_LETTER)
                    else
                        quest:setVar(player, 'Option', 1)
                    end
                end,

                [8] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        player:delKeyItem(xi.ki.RED_RECOMMENDATION_LETTER)
                    end
                end,

                [10] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Option', 1)
                    end
                end,

                [11] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Mainchelite'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.CHARRED_PROPELLER) and
                        player:hasKeyItem(xi.ki.OXIDIZED_PLATE) and
                        player:hasKeyItem(xi.ki.PIECE_OF_SHATTERED_LUMBER)
                    then
                        if player:getCampaignAllegiance() == 0 then
                            return quest:progressEvent(12)
                        else
                            return quest:progressEvent(624)
                        end
                    else
                        local isPledged = player:getCampaignAllegiance() > 0 and 1 or 0

                        return quest:progressEvent(13 + isPledged)
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCampaignAllegiance(1)
                        npcUtil.giveKeyItem(player, xi.ki.BRONZE_RIBBON_OF_SERVICE)

                        player:delKeyItem(xi.ki.CHARRED_PROPELLER)
                        player:delKeyItem(xi.ki.OXIDIZED_PLATE)
                        player:delKeyItem(xi.ki.PIECE_OF_SHATTERED_LUMBER)

                        npcUtil.giveItem(player, xi.item.SPRINTERS_SHOES)

                        player:messageSpecial(southernSandoriaSID.text.NOW_ALLIED_WITH, 1)
                    end
                end,

                [13] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.RED_RECOMMENDATION_LETTER)
                        player:delQuest(quest.areaId, quest.questId)
                    end
                end,

                [14] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(quest.areaId, quest.questId)
                    end
                end,

                [624] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        -- TODO: Adjust medal count for allegiance change.

                        player:setCampaignAllegiance(1)

                        player:delKeyItem(xi.ki.CHARRED_PROPELLER)
                        player:delKeyItem(xi.ki.OXIDIZED_PLATE)
                        player:delKeyItem(xi.ki.PIECE_OF_SHATTERED_LUMBER)

                        player:messageSpecial(southernSandoriaSID.text.NOW_ALLIED_WITH, 1)
                    end
                end,
            },
        },

        [xi.zone.EAST_RONFAURE_S] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.CHARRED_PROPELLER) then
                        return quest:progressEvent(1)
                    end
                end,
            },

            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PIECE_OF_SHATTERED_LUMBER) then
                        return quest:progressEvent(2)
                    end
                end,
            },

            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.OXIDIZED_PLATE) then
                        return quest:progressEvent(3)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CHARRED_PROPELLER)
                end,

                [2] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.PIECE_OF_SHATTERED_LUMBER)
                end,

                [3] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.OXIDIZED_PLATE)
                end,
            },

        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Mainchelite'] = quest:event(5):replaceDefault(),
        },
    },
}

return quest
