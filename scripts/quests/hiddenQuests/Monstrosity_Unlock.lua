-----------------------------------
-- Unlocking Monstrosity
-----------------------------------

-- TODO: There is a Monstrosity Quest in "Other Areas", we should be using that!

local quest = HiddenQuest:new('MonstrosityUnlock')

-- TODO: Handle xi.settings.main.ENABLE_MONSTROSITY

quest.sections =
{
    -- Intro chatter
    {
        check = function(player, questVars, vars)
            return xi.settings.main.ENABLE_MONSTROSITY == 1 and quest:getVar(player, 'Prog') == 0
        end,

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Suspicious_Hume'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(40)
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    -- Reminder
    {
        check = function(player, questVars, vars)
            return quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Suspicious_Hume'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(41)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Suspicious_Tarutaru'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.LIZARD_TAIL)
                    then
                        return quest:progressEvent(881, 926, 0, 0, 0, 0, 0, 0, 4)
                    end
                end,

                -- Reminder
                onTrigger = function(player, npc)
                    return quest:progressEvent(880)
                end,
            },

            onEventFinish =
            {
                [881] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 2)
                        npcUtil.giveKeyItem(player, xi.ki.RING_OF_SUPERNAL_DISJUNCTION)
                    end
                end,
            },
        },
    },

    -- Intro chatter
    {
        check = function(player, questVars, vars)
            return quest:getVar(player, 'Prog') == 2
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Suspicious_Tarutaru'] =
            {
                -- Reminder
                onTrigger = function(player, npc)
                    return quest:progressEvent(882)
                end,
            },
        },
    },

    -- On complete:
    -- xi.monstrosity.unlockStartingMONs(player, xi.monstrosity.species.MANDRAGORA)
    -- Then zone to Feretory
}

return quest
