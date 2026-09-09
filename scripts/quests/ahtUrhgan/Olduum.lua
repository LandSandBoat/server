-----------------------------------
-- Olduum
-- Dkhaaya !pos -73 -1 -6 50
-- Excavation Site !pos 390 1 349 68
-- Leypoint !pos -200 -8.5 80 51
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OLDUUM)

quest.reward =
{
    item = xi.item.LIGHTNING_BAND,
}

local keyItems =
{
    xi.ki.ELECTROCELL,
    xi.ki.ELECTROPOT,
    xi.ki.ELECTROLOCOMOTIVE,
}

local function getQuestKeyItem(player)
    for _, keyItem in ipairs(keyItems) do
        if player:hasKeyItem(keyItem) then
            return keyItem
        end
    end

    return xi.ki.NONE
end

quest.sections =
{
    -- Section: Begin quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Dkhaaya'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(4)
                end
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DKHAAYAS_RESEARCH_JOURNAL)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Dkhaaya'] =
            {
                onTrigger = function(player, npc)
                    local questKeyItem = getQuestKeyItem(player)

                    if questKeyItem > 0 then
                        return quest:progressEvent(6, { [0] = questKeyItem })
                    else
                        return quest:event(5)
                    end
                end
            },

            onEventUpdate =
            {
                [6] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(keyItems[quest:getVar(player, 'Prog')])
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    local cellKeyItem = keyItems[quest:getVar(player, 'Prog')]

                    if quest:complete(player) then
                        player:delKeyItem(cellKeyItem)
                    end
                end,
            },
        },

        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            ['Excavation_Site'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:hasItem(xi.item.OLDUUM_RING) and
                        getQuestKeyItem(player) == xi.ki.NONE and
                        npcUtil.tradeMatches(trade, { { xi.item.PICKAXE, 1 } })
                    then
                        if math.randomInt(1, 100) <= 50 then
                            quest:setVar(player, 'Prog', math.randomInt(1, 3))

                            return quest:progressEvent(0, { [0] = keyItems[quest:getVar(player, 'Prog')] })
                        else
                            player:setLocalVar('mineFail', 1)
                            return quest:progressEvent(0, { [1] = 1 })
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    if player:getLocalVar('mineFail') == 1 then
                        player:setLocalVar('mineFail', 0)
                    else
                        player:addKeyItem(keyItems[quest:getVar(player, 'Prog')])
                    end

                    player:tradeComplete()
                end,
            },
        },
    },

    -- Section: Quest completed
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Dkhaaya'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasItem(xi.item.OLDUUM_RING) or
                        player:hasItem(xi.item.LIGHTNING_BAND) or
                        quest:getVar(player, 'Wait') > GetSystemTime()
                    then
                        return quest:progressEvent(7)
                    end

                    if quest:getVar(player, 'Reissue') == 1 then
                        local questKeyItem = getQuestKeyItem(player)

                        if questKeyItem > 0 then
                            return quest:progressEvent(8, { [0] = questKeyItem })
                        end

                        return quest:progressEvent(7, { [7] = 2 })
                    end

                    return quest:progressEvent(7, { [7] = 1 })
                end,
            },

            onEventUpdate =
            {
                [8] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(keyItems[quest:getVar(player, 'Prog')])
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    if
                        option ~= 99 or
                        player:hasItem(xi.item.OLDUUM_RING) or
                        player:hasItem(xi.item.LIGHTNING_BAND) or
                        getQuestKeyItem(player) > 0 or
                        quest:getVar(player, 'Wait') > GetSystemTime()
                    then
                        return
                    end

                    quest:setVar(player, 'Reissue', 1)
                end,

                [8] = function(player, csid, option, npc)
                    local questKeyItem = getQuestKeyItem(player)

                    if
                        questKeyItem == xi.ki.NONE or
                        player:hasItem(xi.item.OLDUUM_RING) or
                        player:hasItem(xi.item.LIGHTNING_BAND) or
                        quest:getVar(player, 'Reissue') ~= 1 or
                        quest:getVar(player, 'Wait') > GetSystemTime()
                    then
                        return
                    end

                    if not npcUtil.giveItem(player, xi.item.LIGHTNING_BAND) then
                        return
                    end

                    player:delKeyItem(questKeyItem)
                    quest:setVar(player, 'Prog', 0)
                    quest:setVar(player, 'Reissue', 0)
                end,
            },
        },

        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            ['Excavation_Site'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Reissue') == 1 and
                        quest:getVar(player, 'Wait') <= GetSystemTime() and
                        not player:hasItem(xi.item.OLDUUM_RING) and
                        not player:hasItem(xi.item.LIGHTNING_BAND) and
                        getQuestKeyItem(player) == xi.ki.NONE and
                        npcUtil.tradeMatches(trade, { { xi.item.PICKAXE, 1 } })
                    then
                        if math.randomInt(1, 100) <= 50 then
                            quest:setVar(player, 'Prog', math.randomInt(1, 3))

                            return quest:progressEvent(0, { [0] = keyItems[quest:getVar(player, 'Prog')] })
                        else
                            player:setLocalVar('mineFail', 1)
                            return quest:progressEvent(0, { [1] = 1 })
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    if player:getLocalVar('mineFail') == 1 then
                        player:setLocalVar('mineFail', 0)
                    else
                        player:addKeyItem(keyItems[quest:getVar(player, 'Prog')])
                    end

                    player:tradeComplete()
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['Leypoint'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:hasItem(xi.item.OLDUUM_RING) and
                        npcUtil.tradeMatches(trade, { { xi.item.LIGHTNING_BAND, 1 } })
                    then
                        if player:getFreeSlotsCount() == 0 then
                            return quest:messageSpecial(
                                zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED,
                                xi.item.OLDUUM_RING)
                        else
                            return quest:progressEvent(2)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if player:hasItem(xi.item.LIGHTNING_BAND) then
                        return quest:messageSpecial(zones[player:getZoneID()].text.LEYPOINT + 1, xi.item.LIGHTNING_BAND)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if
                        not player:hasItem(xi.item.OLDUUM_RING) and
                        npcUtil.giveItem(player, xi.item.OLDUUM_RING)
                    then
                        player:tradeComplete()
                        quest:setVar(player, 'Wait', GetSystemTime() + 60) -- 1 minute
                    end
                end,
            },
        },
    },
}

return quest
