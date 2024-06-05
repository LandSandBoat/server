-----------------------------------
-- Blackmail
-----------------------------------
-- Log ID: 0, Quest ID: 71
-- Dauperiat !pos -19 -.1 -24 231
-- Halver !pos 2 0 -.6 233
-----------------------------------
local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.BLACKMAIL)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.SANDORIA,
    gil      = 900,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getFameLevel(xi.fameArea.SANDORIA) >= 3 and
            player:getRank(player:getNation()) >= 3
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Dauperiat']  = quest:progressEvent(643),

            onEventFinish =
            {
                [643] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.SUSPICIOUS_ENVELOPE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Dauperiat'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS, 1 } }) and
                        quest:getVar(player, 'Prog') == 2 or
                        quest:getVar(player, 'Repeat') == 1
                    then
                        return quest:progressEvent(648, 0, xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local questRepeat   = quest:getVar(player, 'Repeat')

                    if player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE) then
                        return quest:event(645)
                    elseif questProgress == 1 then
                        return quest:progressEvent(646, 0, xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS)
                    elseif questProgress == 2 then
                        return quest:event(647, 0, xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS)
                    elseif questRepeat == 0 then
                        return quest:progressEvent(650, 0, xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS)
                    elseif questRepeat == 1 then
                        return quest:event(647, 0, xi.item.COPY_OF_THE_CASTLE_FLOOR_PLANS)
                    end
                end,
            },

            onEventFinish =
            {
                [646] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [648] = function(player, csid, option, npc)
                    if player:hasCompletedQuest(quest.areaId, quest.questId) then
                        player:addFame(xi.fameArea.SANDORIA, 5)
                    end

                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [650] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Repeat', 1)
                    end
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SUSPICIOUS_ENVELOPE) then
                        return quest:progressEvent(549)
                    end
                end,
            },

            onEventFinish =
            {
                [549] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:delKeyItem(xi.ki.SUSPICIOUS_ENVELOPE)
                end,
            },
        },
    },
}

return quest
