-----------------------------------
-- Rycharde the Chef
-- Variable Prefix: [4][0]
-----------------------------------
-- ZONE,   NPC,          POS
-- Mhaura, Rycharde,     !pos  17.451 -16.000 88.815 249
-- Mhaura, Take,         !pos  20.616  -8.000 69.757 249
-- Mhaura, Numi Adaligo, !pos -80.332 -24.050 34.794 249
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.RYCHARDE_THE_CHEF)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    title    = xi.title.PURVEYOR_IN_TRAINING,
    gil      = 1500,
}

quest.sections =
{
    -- Section: Quest available. Talk to Numi Adaligo, Take and Rycharde.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:progressEvent(70, xi.item.DHALMEL_MEAT)
                    elseif quest:getVar(player, 'Prog') > 2 then
                        quest:progressEvent(71, xi.item.DHALMEL_MEAT)
                    end
                end,
            },

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:progressEvent(60)
                    elseif quest:getVar(player, 'Prog') > 1 then
                        quest:event(68)
                    end
                end,
            },

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    if option == 2 then -- Ask for work.
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [60] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [70] = function(player, csid, option, npc)
                    if option == 71 then -- Accept quest.
                        quest:begin(player)
                    elseif option == 70 then -- Decline quest.
                        quest:setVar(player, 'Prog', 3)
                    end
                end,

                [71] = function(player, csid, option, npc)
                    if option == 72 then  -- Accept quest.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted. Handle trade outcomes.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(72) -- Interaction dialog.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.DHALMEL_MEAT, 2 } }) then
                        return quest:progressEvent(74) -- Quest completed dialog.
                    elseif npcUtil.tradeHasExactly(trade, { { xi.item.DHALMEL_MEAT, 1 } }) then
                        return quest:event(73) -- "That's not enough!" dialog.
                    end
                end,
            },

            ['Take'] = quest:event(68), -- Optional dialog.

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Used for next quest wait time.
                    end
                end,
            },
        },
    },
}

return quest
