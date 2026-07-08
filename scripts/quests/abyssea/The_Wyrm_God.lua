-----------------------------------
-- The Wyrm God
-----------------------------------
-- !addquest 8 184
-- TR_Entrance    : !pos 539.861 -500.000 -594.576 255
-- Prishe         : !pos 536.353 -499.999 -591.338 255
-- Flagged on completion of Beneath a Blood Red Sky.
-- Defeat Shinryu in the Abyssea-Empyreal Paradox within The Wyrm God battlefield. Talk to Prishe for a CS. Flags "Meanwhile, back on Abyssea" upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.THE_WYRM_GOD)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_EMPYREAL_PARADOX] =
        {
            ['TR_Entrance'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(208)
                    end
                end,
            },

            ['Prishe'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(203)
                    end
                end,
            },

            onEventFinish =
            {
                [208] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [32001] = function(player, csid, option, npc)
                    -- TODO: 'battlefieldWin' local var should be set on successful completion of
                    -- the BCNM with its BCNM ID.  See other examples of this pattern implemented
                    -- in various missions.

                    if
                        player:getLocalVar('battlefieldWin') == xi.battlefield.id.THE_WYRM_GOD and
                        quest:getVar(player, 'Prog') == 1
                    then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [203] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.MEANWHILE_BACK_ON_ABYSSEA)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.ABYSSEA_EMPYREAL_PARADOX] =
        {
            ['Prishe'] = quest:event(206):replaceDefault()
        },
    },
}

return quest
