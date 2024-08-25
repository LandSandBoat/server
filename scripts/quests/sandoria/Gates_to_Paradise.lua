-----------------------------------
-- Gates to Paradise
-----------------------------------
-- !addquest 0 18
-- Olbergieut: !pos 91 0 121 231
-- Faurbellant !pos 484 24 -89 102
-----------------------------------
local northernSandyID = zones[xi.zone.NORTHERN_SAN_DORIA]
local laTheineID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.GATES_TO_PARADISE)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.SANDORIA,
    item = xi.item.COTTON_CAPE,
    title = xi.title.THE_PIOUS_ONE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 2
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Olbergieut'] = quest:progressEvent(619),

            onEventFinish =
            {
                [619] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.SCRIPTURE_OF_WIND)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Olbergieut'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SCRIPTURE_OF_WATER) then
                        return quest:progressEvent(620)
                    elseif player:hasKeyItem(xi.ki.SCRIPTURE_OF_WIND) then
                        return quest:messageSpecial(northernSandyID.text.OLBERGIEUT_DIALOG, xi.ki.SCRIPTURE_OF_WIND)
                    end
                end,
            },

            onEventFinish =
            {
                [620] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SCRIPTURE_OF_WATER)
                    end
                end
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Faurbellant'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SCRIPTURE_OF_WIND) then
                        player:delKeyItem(xi.ki.SCRIPTURE_OF_WIND)
                        npcUtil.giveKeyItem(player, xi.ki.SCRIPTURE_OF_WATER)
                        return quest:messageSpecial(laTheineID.text.FAURBELLANT_2, 0, xi.ki.SCRIPTURE_OF_WIND)
                    elseif player:hasKeyItem(xi.ki.SCRIPTURE_OF_WATER) then
                        return quest:messageSpecial(laTheineID.text.FAURBELLANT_3, xi.ki.SCRIPTURE_OF_WATER):replaceDefault()
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Faurbellant'] =
            {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(laTheineID.text.FAURBELLANT_4)
                end,
            },
        },
        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Olbergieut'] =
            {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(northernSandyID.text.OLBERGIEUT_DIALOG_II)
                end,
            },
        },
    },
}

return quest
