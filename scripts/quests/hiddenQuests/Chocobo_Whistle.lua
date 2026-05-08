-----------------------------------
-- Chocobo Whistle
-----------------------------------
-- Hantileon : !pos -2.675 -1.1 -105.287 230
-----------------------------------

local quest = HiddenQuest:new('ChocoboWhistle')

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return xi.settings.main.ENABLE_CHOCOBO_RAISING and
                questVars.Prog == 1
                -- TODO: Also check chocobo is large enough to ride
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hantileon'] =
            {
                onTrigger = function(player, npc, trade)
                    -- TODO: use onEventUpdate to inject chocobo name?
                    return quest:progressEvent(829, 0, 0, 1, 0, 4, 1, 0, 0)
                end,
            },

            onEventFinish =
            {
                [829] = function(player, csid, option, npc)
                    -- TODO: Handle option?
                    -- We'll check this inside the chocobo walk event logic
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- TODO: Chocobo Walk sets Prog from 2 to 3

    {
        check = function(player, questVars, vars)
            return xi.settings.main.ENABLE_CHOCOBO_RAISING and
                questVars.Prog == 3
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hantileon'] =
            {
                onTrigger = function(player, npc, trade)
                    -- TODO: use onEventUpdate to inject chocobo name?
                    -- TODO: Guessed params:
                    -- Dirty Handkerchief
                    return quest:progressEvent(830, 0, 1)

                    -- Regular handkerchief:
                    -- (given to chocobo by the stable workers)
                    -- return quest:progressEvent(830, 0, 2)
                end,
            },

            onEventFinish =
            {
                [830] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CHOCOBO_WHISTLE) then
                        -- Rather than complete and wipe the var, we need to keep it around for
                        -- future reference and CSs (there's no key item or anything to track)
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },
    },
}

return quest
