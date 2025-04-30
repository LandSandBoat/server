-----------------------------------
-- Exit the Gambler
-----------------------------------
-- Log ID: 0, Quest ID: 101
-- Aurege       : !pos -156.253 11.999 253.691 231
-- Guilberdrier : !pos -159.082 12.000 253.794 231
-- Varchet      : !pos 116.484 -1 91.554 230
-----------------------------------
local northenSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
local southernSandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER)

quest.reward =
{
    exp   = 2000,
    ki    = xi.ki.MAP_OF_KING_RANPERRES_TOMB,
    title = xi.title.DAYBREAK_GAMBLER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                vars.Stage == 0
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Aurege'] = quest:progressEvent(521),

            ['Guilberdrier'] = quest:progressEvent(521),

            onEventFinish =
            {
                [521] = function(player, csid, option, npc)
                    quest:setVar(player, 'Stage', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Stage == 1
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Aurege'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(516)
                    else
                        return quest:messageText(northenSandoriaID.text.GAMBLING_IS_THE_RUIN) -- Reminder
                    end
                end,
            },

            ['Guilberdrier'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(518)
                    else
                        return quest:messageText(northenSandoriaID.text.WHO_DOES_HE_THINK) -- Reminder
                    end
                end,
            },

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [518] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Varchet'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        not quest:getMustZone(player)
                    then
                        return quest:event(638):oncePerZone()
                    else
                        return quest:event(643)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Aurege'] = quest:event(514):replaceDefault(),

            ['Guilberdrier'] = quest:messageText(northenSandoriaID.text.HE_WAS_JUST_HERE):replaceDefault(),
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Varchet'] = quest:messageText(southernSandoriaID.text.NOBODY_ONE_WANTS_TO_PLAY):replaceDefault(),
        },

    },
}

return quest
