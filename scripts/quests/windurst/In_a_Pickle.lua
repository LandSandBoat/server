-----------------------------------
-- In a Pickle
-----------------------------------
-- Log ID: 2, Quest ID: 5
-- Chamama : !pos -70.244, -3.800, -4.439 238
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)

quest.reward =
{
    fame       = 75,
    fameArea   = xi.fameArea.WINDURST,
    item       = xi.item.BONE_HAIRPIN,
    itemParams = { fromTrade = true, }
}

local function handleTurnIn(player, trade)
    if npcUtil.tradeHasExactly(trade, xi.item.SMOOTH_STONE) then
        player:confirmTrade()
        local rand = math.random(1, 4)
        if rand <= 2 then
            return quest:progressEvent(659)
        elseif rand == 3 then
            return quest:progressEvent(657) -- IN A PICKLE: Too Light
        elseif rand == 4 then
            return quest:progressEvent(658) -- IN A PICKLE: Too Small
        end
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chamama'] = quest:progressEvent(654, 0, xi.item.RARAB_TAIL),

            onEventFinish =
            {
                [654] = function(player, csid, option, npc)
                    if option == 1 then
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

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chamama'] =
            {
                onTrade = function(player, npc, trade)
                    return handleTurnIn(player, trade)
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(655, 0, xi.item.RARAB_TAIL) -- IN A PICKLE + RARAB TAIL: Quest Objective Reminder
                end,
            },

            onEventFinish =
            {
                [659] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addGil(200)
                        player:needToZone(true)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chamama'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'repeat') == 1 then
                        return handleTurnIn(player, trade)
                    end
                end,

                onTrigger = function(player, npc)
                    local needToZone = player:needToZone()
                    if needToZone then
                        return quest:progressEvent(660) -- IN A PICKLE: After Quest
                    elseif quest:getVar(player, 'repeat') == 1 then
                        return quest:progressEvent(655, 0, xi.item.RARAB_TAIL) -- IN A PICKLE + RARAB TAIL: Quest Objective Reminder
                    else
                        return quest:event(661):setPriority(10) -- IN A PICKLE: Repeatable Quest Begin cycle with default
                    end
                end,
            },

            onEventFinish =
            {
                [661] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'repeat', 1)
                    end
                end,

                [662] = function(player, csid, option, npc)
                    player:needToZone(true)
                    quest:setVar(player, 'repeat', 0)
                    player:addFame(xi.quest.fame_area.WINDURST, 8)
                    player:addGil(200)
                end,
            },
        },
    },
}

return quest
