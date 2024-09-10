-----------------------------------
-- Divine Might
-----------------------------------
-- Log ID: 5, Quest ID: 163
-- blank_divine_might : !pos -40 0 -151 178
-- Qu'Hau Spring      : !pos 0 -29 64 122
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)

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

local onTriggerIncomplete = function(player, npc)
    local currentMission = player:getCurrentMission(xi.mission.log_id.ZILART)

    if
        currentMission == xi.mission.id.zilart.ARK_ANGELS and
        player:getMissionStatus(xi.mission.log_id.ZILART) == 1
    then
        return quest:event(54, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK, xi.item.ARK_PENTASPHERE)
    elseif currentMission >= xi.mission.id.zilart.ARK_ANGELS then
        -- NOTE: In order for a player to have the appropriate KI for an event to be displayed, they will be at least
        -- at missionStatus 1, so no need to verify greater than.

        for keyItemId = xi.ki.SHARD_OF_APATHY, xi.ki.SHARD_OF_RAGE do
            if player:hasKeyItem(keyItemId) then
                return quest:event(56, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK, xi.item.ARK_PENTASPHERE)
            end
        end
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.THE_SHRINE_OF_RUAVITAU] =
        {
            ['blank_divine_might'] = onTriggerIncomplete,

            onEventFinish =
            {
                [54] = function(player, csid, option, npc)
                    quest:begin(player)
                end,

                [56] = function(player, csid, option, npc)
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
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(55, xi.item.SUPPANOMIMI, xi.item.KNIGHTS_EARRING, xi.item.ABYSSAL_EARRING, xi.item.BEASTLY_EARRING, xi.item.BUSHINOMIMI)
                    else
                        return onTriggerIncomplete(player, npc)
                    end
                end,
            },

            onEventUpdate =
            {
                [55] = function(player, csid, option, npc)
                    if option == 2 then
                        player:updateEvent(xi.item.SUPPANOMIMI, xi.item.KNIGHTS_EARRING, xi.item.ABYSSAL_EARRING, xi.item.BEASTLY_EARRING, xi.item.BUSHINOMIMI)
                    end
                end,
            },

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
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
                        (vanaHour >= 18 or vanaHour < 6) and
                        npcUtil.tradeHasExactly(trade, { xi.item.BOTTLE_OF_ILLUMININK, xi.item.SHEET_OF_PARCHMENT })
                    then
                        return quest:progressEvent(7, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK)
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
            },
        },

        [xi.zone.LALOFF_AMPHITHEATER] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.DIVINE_MIGHT then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
}

return quest
