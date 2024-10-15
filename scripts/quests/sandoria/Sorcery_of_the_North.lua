-----------------------------------
-- Sorcery of the North
-----------------------------------
-- !addquest 0 83
-- Eperdur: !pos 129 -6 96 231
-----------------------------------
---@type TQuest
local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.SANDORIA,
    item = xi.item.SCROLL_OF_TELEPORT_VAHZL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND) and
                not quest:getMustZone(player)
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Eperdur'] = quest:progressEvent(685),

            onEventFinish =
            {
                [685] = function(player, csid, option, npc)
                    quest:begin(player)
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
            ['Eperdur'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.FEIYIN_MAGIC_TOME) then
                        return quest:event(686)
                    else
                        return quest:progressEvent(687)
                    end
                end,
            },

            onEventFinish =
            {
                [687] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
