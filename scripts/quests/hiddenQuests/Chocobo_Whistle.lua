-----------------------------------
-- Chocobo Whistle
-----------------------------------
-- Hantileon : !pos -2.675 -0.100 -105.287 230
-----------------------------------
-- Starts when a raised chocobo grows up; see xi.chocoboRaising.whistle.prog.
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/whistle')
-----------------------------------

local quest = HiddenQuest:new('ChocoboWhistle')
local prog  = xi.chocoboRaising.whistle.prog

-- Event 830 text. TODO: Nothing sends 3, the text for Hantileon's own handkerchief.
---@enum handkerchiefText
local handkerchiefText =
{
    DIRTY       = 1,
    FROM_WORKER = 2,
}

local function startStringEvent(player, csid, ...)
    local chocoState = player:getChocoboRaisingInfo()
    local fullName   = ''
    local firstName  = ''
    local lastName   = ''
    if chocoState then
        fullName, firstName, lastName = xi.chocoboRaising.nameStrings(chocoState)
    end

    player:startEventString(csid, fullName, firstName, lastName, '', ...)

    return quest:noAction()
end

quest.sections =
{
    -- Step 1: Hantileon's scene starts the search, which runs on the chocobo's walks.
    {
        check = function(player, questVars, vars)
            return xi.settings.main.ENABLE_CHOCOBO_RAISING and
                questVars.Prog == prog.SEE_HANTILEON
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hantileon'] =
            {
                onTrigger = function(player, npc)
                    return startStringEvent(player, 829, VanadielTime(), 0, 0, 2)
                end,
            },

            onEventUpdate =
            {
                [829] = function(player, csid, option, npc)
                    -- 244 is the event asking to draw the chocobo.
                    if option == 244 then
                        player:updateEvent(0, 0, 1, 0, 4, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [829] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', prog.SEARCH)
                end,
            },
        },
    },

    -- Step 2: Bring the handkerchief back to Hantileon (Reward: Chocobo Whistle).
    {
        check = function(player, questVars, vars)
            return xi.settings.main.ENABLE_CHOCOBO_RAISING and
                questVars.Prog == prog.FOUND
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hantileon'] =
            {
                onTrigger = function(player, npc)
                    local variant = player:hasKeyItem(xi.keyItem.HANDKERCHIEF) and handkerchiefText.FROM_WORKER or handkerchiefText.DIRTY

                    return startStringEvent(player, 830, VanadielTime(), variant)
                end,
            },

            onEventFinish =
            {
                [830] = function(player, csid, option, npc)
                    if option ~= xi.chocoboRaising.whistle.option.RECEIVE_WHISTLE then
                        return
                    end

                    xi.chocoboRaising.setWhistleProgress(player, prog.DONE)
                    player:delKeyItem(xi.keyItem.DIRTY_HANDKERCHIEF)
                    player:delKeyItem(xi.keyItem.HANDKERCHIEF)
                    xi.chocoboRaising.whistle.giveQuestWhistle(player)
                end,
            },
        },
    },
}

return quest
