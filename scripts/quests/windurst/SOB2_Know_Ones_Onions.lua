-----------------------------------
-- Know One's Onions
--
-- Kohlo-Lakolo, !pos -26.8 -6 190 240
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.KNOW_ONES_ONIONS)

quest.reward =
{
    fame     = 10,
    fameArea = xi.quest.fame_area.WINDURST,
    item     = xi.item.SCROLL_OF_BLAZE_SPIKES,
    title    = xi.title.SOB_SUPER_HERO,
}

-- NOTE
-- This quest has a peculiarity. You can "miss" the events of the quest by arriving "late".
-- You can be late/meet the cutoff mid-quest or start already late.
-- This effectively means the quest branches off.

-- The cutoff/timer/event that makes it change is currently unkonwn.

-- For now, and becouse of the in-game lore, it's going to be assumed that the cutoff is based on Windurst rank.
-- There is a testimony that "supports" this theory, stating that the cutoff is based on "Old Ring" Key item obtention.
-- Old Ring is a temporal KI, so checking for it wouldn't be a lasting solution.

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUTH_JUSTICE_AND_THE_ONION_WAY)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainLvl() >= 5 and
                        not quest:getMustZone(player)
                    then
                        if player:getRank(xi.nation.WINDURST) < 3 then
                            return quest:progressEvent(391, 0, xi.item.WILD_ONION) -- Quest starting event. (In time)
                        else
                            return quest:progressEvent(388, 0, xi.item.WILD_ONION) -- Quest starting event. (Missed action)
                        end
                    else
                        return quest:event(379) -- Default text.
                    end
                end,
            },

            onEventFinish =
            {
                [388] = function(player, csid, option, npc)
                    quest:begin(player)
                end,

                [391] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepeted in time.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                vars.Prog == 1 and
                player:getRank(xi.nation.WINDURST) < 3
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(392, 0, xi.item.WILD_ONION) -- Reminder text if you are still in time.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.WILD_ONION, 4 } }) then
                        return quest:progressEvent(398, 0, xi.item.WILD_ONION) -- Trade in time. Quest goes on.
                    end
                end,
            },

            ['Gomada-Vulmada'] = quest:event(394),
            ['Papo-Hopo']      = quest:event(393),
            ['Pichichi']       = quest:event(395),
            ['Pyo_Nzon']       = quest:event(396),
            ['Yafa_Yaa']       = quest:event(397),

            onEventFinish =
            {
                [398] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Section: Trade performed in time.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                vars.Prog == 2 and
                player:getRank(xi.nation.WINDURST) < 3
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Gomada-Vulmada'] = quest:event(394),
            ['Kohlo-Lakolo']   = quest:event(399, 0, xi.item.WILD_ONION),
            ['Papo-Hopo']      = quest:event(393),
            ['Pichichi']       = quest:event(395),
            ['Pyo_Nzon']       = quest:event(396),
            ['Yafa_Yaa']       = quest:event(397),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] = quest:progressEvent(288, 0, xi.item.WILD_ONION),

            onEventFinish =
            {
                [288] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    -- Section: Expedition complete. End quest.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                vars.Prog == 3
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Gomada-Vulmada'] = quest:event(404),
            ['Kohlo-Lakolo']   = quest:progressEvent(400),
            ['Papo-Hopo']      = quest:event(402),
            ['Pichichi']       = quest:event(410),
            ['Pyo_Nzon']       = quest:event(408),
            ['Yafa_Yaa']       = quest:event(406),

            onEventFinish =
            {
                [400] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLocalVar('[2][41]mustZone', 1)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted. You are late at any step of the process, except very last step.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                vars.Prog < 3 and
                player:getRank(xi.nation.WINDURST) >= 3
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(389, 0, xi.item.WILD_ONION) -- Reminder text: Started quest late.
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(387, 0, xi.item.WILD_ONION) -- Reminder text: In time for introduction but late before trade is done.
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(386)                         -- Reminder text: Late after trade. Quest Complete.
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.WILD_ONION, 4 } }) then
                        return quest:progressEvent(390) -- Quest Complete.
                    end
                end,
            },

            ['Gomada-Vulmada'] = quest:event(405),
            ['Papo-Hopo']      = quest:event(403),
            ['Pichichi']       = quest:event(411),
            ['Pyo_Nzon']       = quest:event(409),
            ['Shanruru']       = quest:event(412),
            ['Yafa_Yaa']       = quest:event(407),

            onEventFinish =
            {
                [386] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLocalVar('[2][41]mustZone', 1)
                    end
                end,

                [390] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:setLocalVar('[2][41]mustZone', 1)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.INSPECTORS_GADGET) == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            -- New default texts.
            ['Gomada-Vulmada'] = quest:event(405):replaceDefault(),
            ['Papo-Hopo']      = quest:event(403):replaceDefault(),
            ['Pichichi']       = quest:event(411):replaceDefault(),
            ['Pyo_Nzon']       = quest:event(409):replaceDefault(),
            ['Shanruru']       = quest:event(412):replaceDefault(),
            ['Yafa_Yaa']       = quest:event(407):replaceDefault(),
        },
    },
}

return quest
