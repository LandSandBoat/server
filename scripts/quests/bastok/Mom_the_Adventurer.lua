-----------------------------------
-- Mom, the Adventurer?
-----------------------------------
-- Log ID: 1, Quest ID: 21
-- Nbu Latteh : !pos -114.777 -4 -113.301 235
-- Roh Latteh : !pos -11.823 6.999 -9.249 234
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.MOM_THE_ADVENTURER)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.BASTOK,
    title    = xi.title.RINGBEARER,
}

local handleEventFinish = function(player, csid, option, npc)
    if quest:complete(player) then
        local gilReward = csid == 233 and 200 or 100

        player:delKeyItem(xi.ki.LETTER_FROM_ROH_LATTEH)
        npcUtil.giveCurrency(player, 'gil', gilReward)
        quest:setMustZone(player)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Nbu_Latteh'] = quest:progressEvent(230),

            onEventFinish =
            {
                [230] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.FIRE_CRYSTAL) then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Nbu_Latteh'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LETTER_FROM_ROH_LATTEH) then
                        if player:seenKeyItem(xi.ki.LETTER_FROM_ROH_LATTEH) then
                            return quest:progressEvent(234)
                        else
                            return quest:progressEvent(233)
                        end
                    else
                        return quest:event(231)
                    end
                end,
            },

            onEventFinish =
            {
                [233] = handleEventFinish,
                [234] = handleEventFinish,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Roh_Latteh'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.COPPER_RING) and
                        not player:hasKeyItem(xi.ki.LETTER_FROM_ROH_LATTEH)
                    then
                        return quest:progressEvent(95)
                    end
                end,
            },

            onEventFinish =
            {
                [95] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_ROH_LATTEH)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                not quest:getMustZone(player)
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Nbu_Latteh'] =
            {
                onTrigger = function(player, npc)
                    -- Allow quest completion regardless of fame level.
                    if player:hasKeyItem(xi.ki.LETTER_FROM_ROH_LATTEH) then
                        if player:seenKeyItem(xi.ki.LETTER_FROM_ROH_LATTEH) then
                            return quest:progressEvent(234)
                        else
                            return quest:progressEvent(233)
                        end
                    end

                    -- Allow quest repeat at Bastok fame 1.
                    local questProgress = quest:getVar(player, 'Prog')
                    if
                        player:getFameLevel(xi.fameArea.BASTOK) == 1 and
                        questProgress == 0
                    then
                        return quest:progressEvent(230)

                    -- Now you are stuck.
                    elseif questProgress == 1 then
                        return quest:event(231)
                    end
                end,
            },

            ['Roh_Latteh'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        not player:hasKeyItem(xi.ki.LETTER_FROM_ROH_LATTEH) and
                        npcUtil.tradeHasExactly(trade, xi.item.COPPER_RING)
                    then
                        return quest:progressEvent(95)
                    end
                end,
            },

            onEventFinish =
            {
                [95] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_ROH_LATTEH)
                end,

                [230] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.FIRE_CRYSTAL) then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [233] = handleEventFinish,
                [234] = handleEventFinish,
            },
        },
    },
}

return quest
