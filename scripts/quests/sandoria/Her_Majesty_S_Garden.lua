-----------------------------------
-- Her Majestys Garden
-----------------------------------
-- Log ID: 0, Quest ID: 62
-- Chalvatot : !pos -105 0.1 72 233
-- Reward : Map of the Northlands
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.HER_MAJESTY_S_GARDEN)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.SANDORIA,
    keyItem  = xi.ki.MAP_OF_THE_NORTHLANDS_AREA,
    gil      = 2000,
    xp       = 2000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getFameLevel(xi.fameArea.SANDORIA) >= 4
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Chalvatot'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        if  player:getNation() ~= xi.nation.SANDORIA then -- Non sandy folk gets a CS prior to getting acceptance
                            return quest:progressEvent(538)
                        else -- Sandy folks go directly to CS acceptance
                            return quest:progressEvent(84)
                        end
                    elseif questProgress == 1 then
                        return quest:progressEvent(84)
                    end
                end,
            },

            onEventFinish =
            {
                [538] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [84] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Chalvatot'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(82)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.CHUNK_OF_DERFLAND_HUMUS }) then
                        return quest:progressEvent(83)
                    end
                end,

            },

            onEventFinish =
            {
                [83] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
