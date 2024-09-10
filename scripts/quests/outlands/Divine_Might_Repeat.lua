-----------------------------------
-- Divine Might (Repeat)
-----------------------------------
-- Log ID: 5, Quest ID: 164
-- blank_divine_might : !pos -40 0 -151 178
-- Qu'Hau Spring      : !pos 0 -29 64 122
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)

quest.reward =
{
    title = xi.title.PENTACIDE_PERPETRATOR,
}

local earringRewards =
{
    [1] = xi.item.SUPPANOMIMI,
    [2] = xi.item.KNIGHTS_EARRING,
    [3] = xi.item.ABYSSAL_EARRING,
    [4] = xi.item.BEASTLY_EARRING,
    [5] = xi.item.BUSHINOMIMI,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_ACCEPTED and
                player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)
        end,

        [xi.zone.THE_SHRINE_OF_RUAVITAU] =
        {
            ['blank_divine_might'] =
            {
                onTrigger = function(player, npc)
                    local numEarrings = 0
                    for itemId = xi.item.SUPPANOMIMI, xi.item.BUSHINOMIMI do
                        if player:hasItem(itemId) then
                            numEarrings = numEarrings + 1
                        end
                    end

                    if numEarrings < xi.settings.main.NUMBER_OF_DM_EARRINGS then
                        return quest:progressEvent(57, player:getCharVar('DM_Earring'))
                    end
                end,
            },

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.THE_SHRINE_OF_RUAVITAU] =
        {
            ['blank_divine_might'] =
            {
                onTrigger = function(player, npc)
                    local hasMoonOre = player:hasKeyItem(xi.ki.MOONLIGHT_ORE)

                    if quest:getVar(player, 'Prog') == 0 then
                        if not hasMoonOre then
                            return quest:event(58)
                        else
                            return quest:event(56, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK, xi.item.ARK_PENTASPHERE)
                        end
                    elseif hasMoonOre then
                        return quest:progressEvent(59)
                    end
                end,
            },

            onEventUpdate =
            {
                [59] = function(player, csid, option, npc)
                    if option == 2 then
                        player:updateEvent(xi.item.SUPPANOMIMI, xi.item.KNIGHTS_EARRING, xi.item.ABYSSAL_EARRING, xi.item.BEASTLY_EARRING, xi.item.BUSHINOMIMI)
                    end
                end,
            },

            onEventFinish =
            {
                [59] = function(player, csid, option, npc)
                    local selectedReward = earringRewards[option]

                    if
                        selectedReward and
                        npcUtil.giveItem(player, selectedReward)
                    then
                        quest:complete(player)

                        -- TODO: Find a way to prevent the need for using a forever charVar here.
                        player:setCharVar('DM_Earring', selectedReward)
                    end
                end,
            },
        },

        [xi.zone.ROMAEVE] =
        {
            ['QuHau_Spring'] =
            {
                onTrade = function(player, npc, trade)
                    local vanaHour = VanadielHour()

                    if
                        IsMoonFull() and
                        (vanaHour >= 18 or vanaHour < 6)
                    then
                        if npcUtil.tradeHasExactly(trade, { xi.item.BOTTLE_OF_ILLUMININK, xi.item.SHEET_OF_PARCHMENT }) then
                            return quest:progressEvent(7, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK)
                        elseif
                            npcUtil.tradeHasExactly(trade, xi.item.CHUNK_OF_LIGHT_ORE) and
                            not player:hasKeyItem(xi.ki.MOONLIGHT_ORE)
                        then
                            return quest:progressEvent(8)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.ARK_PENTASPHERE) then
                        player:confirmTrade()
                    end
                end,

                [8] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MOONLIGHT_ORE)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.LALOFF_AMPHITHEATER] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == xi.battlefield.id.DIVINE_MIGHT and
                        player:hasKeyItem(xi.ki.MOONLIGHT_ORE)
                    then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
}

return quest
