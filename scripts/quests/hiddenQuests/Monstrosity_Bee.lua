-----------------------------------
-- Monstrosity: Suibhne Bee Guessing Game
-----------------------------------
-- Suibhne : !pos -366 -3.612 -466 285
-----------------------------------
local feretoryID = zones[xi.zone.FERETORY]
-----------------------------------

local quest = HiddenQuest:new('monstrosityBee')

quest.reward = {}

local choices =
{
    AENGUS  = 1,
    MACCUS  = 2,
    SUIBHNE = 3,
    TERYNON = 4,
}

local answerKey =
{
    [1] = { [0] = choices.TERYNON, [1] = choices.AENGUS,  [2] = choices.SUIBHNE },
    [2] = { [0] = choices.TERYNON, [1] = choices.SUIBHNE, [2] = choices.AENGUS  },
    [3] = { [0] = choices.AENGUS,  [1] = choices.TERYNON, [2] = choices.SUIBHNE },
    [4] = { [0] = choices.AENGUS,  [1] = choices.SUIBHNE, [2] = choices.TERYNON },
    [5] = { [0] = choices.SUIBHNE, [1] = choices.AENGUS,  [2] = choices.TERYNON },
    [6] = { [0] = choices.SUIBHNE, [1] = choices.TERYNON, [2] = choices.AENGUS  },
}

local function getCheckValue(choiceNum)
    local checkValue = 0

    for fieldPos, correctChoice in pairs(answerKey[choiceNum]) do
        checkValue = checkValue + bit.lshift(correctChoice, 16 + 3 * fieldPos)
    end

    return checkValue
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return xi.settings.main.ENABLE_MONSTROSITY == 1 and
                quest:getVar(player, 'Timer') <= VanadielUniqueDay() and
                not xi.monstrosity.hasUnlockedSpecies(player, xi.monstrosity.species.BEE)
        end,

        [xi.zone.FERETORY] =
        {
            ['Suibhne'] =
            {
                onTrigger = function(player, npc)
                    local quizInfo = quest:getVar(player, 'Option')

                    if quizInfo == 0 then
                        quizInfo = math.random(1, 6)
                        quest:setVar(player, 'Option', quizInfo)
                    end

                    return quest:progressEvent(11, 1, quizInfo - 1)
                end,
            },

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    if option == 1 + getCheckValue(quest:getVar(player, 'Option')) then
                        if quest:complete(player) then
                            xi.monstrosity.unlockSpecies(xi.monstrosity.species.BEE)
                            player:messageSpecial(feretoryID.text.MAY_POSSESS_BEES)
                        end
                    elseif option == 2 then
                        quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return quest
