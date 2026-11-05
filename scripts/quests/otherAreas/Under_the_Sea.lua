-----------------------------------
-- Under the Sea
-----------------------------------
-- Log ID: 4, Quest ID: 17
-- !addquest 4 17
-- Yaya    : !pos -18.770 -2.597 -14.929 248
-- Oswald  : !pos 47.119 -15.273 7.989 248
-- Jimaida : !pos -17.342 -2.597 -18.766 248
-- Zaldon  : !pos -11.810 -7.287 -6.742 248
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA)

quest.reward =
{
    title = xi.title.LIL_CUPID,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 2
        end,

        [xi.zone.SELBINA] =
        {
            ['Yaya'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(31)
                    end
                end,
            },

            ['Oswald'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(32) -- Oswald is looking for his ring
                    end
                end,
            },

            ['Jimaida'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(33) -- Go see Zaldon
                    end
                end,
            },

            onEventFinish =
            {
                [31] = function(player, csid, option, npc)
                    if option == 50 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [32] = function(player, csid, option, npc)
                    if option == 50 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [33] = function(player, csid, option, npc)
                    if option == 51 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.keyItem.ETCHED_RING) and
                        quest:getVar(player, 'Prog') ~= 6
                    then
                        return
                    end

                    local event = quest:progressEvent(37)

                    -- Give the reward only when this event is chosen.
                    event.perform = function(self, playerArg, npcArg)
                        -- The reward was already given if the player disconnected during the event.
                        if quest:getVar(playerArg, 'Prog') == 6 then
                            return Event.perform(self, playerArg, npcArg)
                        end

                        if not npcUtil.giveItem(playerArg, xi.item.AMBER_EARRING, { silent = true }) then
                            playerArg:messageSpecial(zones[xi.zone.SELBINA].text.ITEM_CANNOT_BE_OBTAINED, xi.item.AMBER_EARRING)
                            return
                        end

                        playerArg:addFame(xi.fameArea.SANDORIA, 10)
                        playerArg:addFame(xi.fameArea.BASTOK, 10)
                        playerArg:delKeyItem(xi.keyItem.ETCHED_RING)
                        quest:setVar(playerArg, 'Prog', 6)

                        return Event.perform(self, playerArg, npcArg)
                    end

                    return event
                end,
            },

            ['Zaldon'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') ~= 4 or
                        player:hasKeyItem(xi.keyItem.ETCHED_RING)
                    then
                        return
                    end

                    local event
                    if npcUtil.tradeMatches(trade, { { xi.item.FAT_GREEDIE, 1 } }) then
                        event = quest:progressEvent(35)
                    elseif npcUtil.tradeMatches(trade, { { xi.item.GREEDIE, 1 } }) then
                        event = quest:progressEvent(36)
                    else
                        return
                    end

                    -- Take the fish only when this event is chosen.
                    event.perform = function(self, playerArg, npcArg)
                        playerArg:tradeComplete()

                        if self.id == 35 then
                            playerArg:addKeyItem(xi.keyItem.ETCHED_RING)
                            quest:setVar(playerArg, 'Prog', 5)
                        end

                        return Event.perform(self, playerArg, npcArg)
                    end

                    return event
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(34, xi.item.GREEDIE, 1, 0, 0, xi.item.LU_SHANGS_FISHING_ROD, xi.item.MINNOW, 6, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [34] = function(player, csid, option, npc)
                    if option == 50 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,

                [35] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        player:messageSpecial(zones[xi.zone.SELBINA].text.KEYITEM_OBTAINED, xi.keyItem.ETCHED_RING)
                    end
                end,

                [37] = function(player, csid, option, npc)
                    if
                        quest:getVar(player, 'Prog') == 6 and
                        quest:complete(player)
                    then
                        player:messageSpecial(zones[xi.zone.SELBINA].text.ITEM_OBTAINED, xi.item.AMBER_EARRING)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] = quest:event(38):replaceDefault(),
        },
    },
}

return quest
