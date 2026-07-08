-----------------------------------
-- Snake on the Plains
-----------------------------------
-- !addquest 7 8
-- Miah Riyuh        : !pos 5.323 -2 37.462 94
-- Sealed Entrance_1 : !pos -245.000 -18.100 660.000 95
-- Sealed Entrance_2 : !pos 263.600 -6.512 40.000 95
-- Sealed Entrance_3 : !pos -340.000 1.825 -364.825 95
-----------------------------------
local windurstWatersID   = zones[xi.zone.WINDURST_WATERS_S]
local westSarutabarutaID = zones[xi.zone.WEST_SARUTABARUTA_S]
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)

quest.reward =
{
    title = xi.title.COBRA_UNIT_MERCENARY,
}

local otherNationAccepted = function(player)
    return player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS) == xi.questStatus.QUEST_ACCEPTED or
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == xi.questStatus.QUEST_ACCEPTED
end

local sealDoor = function(player, bitNum)
    local doors = quest:getVar(player, 'Doors')

    if utils.mask.getBit(doors, bitNum) then
        return quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 2, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
    end

    local sealed = utils.mask.setBit(doors, bitNum, true)
    quest:setVar(player, 'Doors', sealed)

    if utils.mask.isFull(sealed, 3) then
        player:delKeyItem(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)

        return quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 4, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
    end

    return quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 1, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
end

local sealedEntrance =
{
    onTrigger = function(player, npc)
        if player:hasKeyItem(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY) then
            -- Sealed_Entrance_1/2/3 map to door bits 0/1/2.
            local bitNum = tonumber(string.sub(npc:getName(), -1)) - 1

            return sealDoor(player, bitNum)
        end

        return quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 3)
    end,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Miah_Riyuh'] =
            {
                onTrigger = function(player, npc)
                    if otherNationAccepted(player) then
                        return quest:event(122)
                    elseif player:hasKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER) then
                        return quest:progressEvent(103)
                    elseif quest:getVar(player, 'LetterUsed') == 1 or player:getCampaignAllegiance() > 0 then
                        -- Already spent a letter on a previous attempt, no second letter needed.
                        return quest:progressEvent(105)
                    else
                        return quest:event(121)
                    end
                end,
            },

            onEventFinish =
            {
                [103] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
                        quest:setVar(player, 'LetterUsed', 1)
                        player:delKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER)
                    elseif option == 1 then
                        quest:setVar(player, 'LetterUsed', 1)
                        player:delKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER)
                    end
                end,

                [105] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
                    end
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA_S] =
        {
            ['Sealed_Entrance_1'] = quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 3),
            ['Sealed_Entrance_2'] = quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 3),
            ['Sealed_Entrance_3'] = quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 3),
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Miah_Riyuh'] =
            {
                onTrigger = function(player, npc)
                    if otherNationAccepted(player) then
                        return quest:event(122)
                    end

                    local doors = quest:getVar(player, 'Doors')

                    if utils.mask.isFull(doors, 3) then
                        return quest:progressEvent(106)
                    elseif player:hasKeyItem(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY) then
                        local puttyUsed = 0
                        for bitNum = 0, 2 do
                            if utils.mask.getBit(doors, bitNum) then
                                puttyUsed = puttyUsed + 1
                            end
                        end

                        return quest:progressEvent(104, { [7] = puttyUsed })
                    else
                        return quest:event(121)
                    end
                end,
            },

            onEventFinish =
            {
                [104] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(quest.areaId, quest.questId)
                        player:delKeyItem(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
                        quest:setVar(player, 'Doors', 0)
                    end
                end,

                [106] = function(player, csid, option, npc)
                    if option ~= 0 then
                        return
                    end

                    local hasNoAllegiance = player:getCampaignAllegiance() == 0

                    if
                        hasNoAllegiance and
                        not npcUtil.giveItem(player, xi.item.SPRINTERS_SHOES)
                    then
                        return
                    end

                    if quest:complete(player) then
                        if hasNoAllegiance then
                            npcUtil.giveKeyItem(player, xi.ki.BRONZE_RIBBON_OF_SERVICE)
                        end

                        player:setCampaignAllegiance(3)
                        player:messageSpecial(windurstWatersID.text.NOW_ALLIED_WITH, 3)
                    end
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA_S] =
        {
            ['Sealed_Entrance_1'] = sealedEntrance,
            ['Sealed_Entrance_2'] = sealedEntrance,
            ['Sealed_Entrance_3'] = sealedEntrance,
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Miah_Riyuh'] =
            {
                onTrigger = function(player, npc)
                    if otherNationAccepted(player) then
                        return quest:event(122)
                    elseif player:getCampaignAllegiance() == 3 then
                        return quest:event(107)
                    else
                        return quest:event(121)
                    end
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA_S] =
        {
            ['Sealed_Entrance_1'] = quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 2, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY):replaceDefault(),
            ['Sealed_Entrance_2'] = quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 2, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY):replaceDefault(),
            ['Sealed_Entrance_3'] = quest:messageSpecial(westSarutabarutaID.text.DOOR_OFFSET + 2, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY):replaceDefault(),
        },
    },
}

return quest
