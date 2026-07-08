-----------------------------------
-- The Tigress Stirs
-----------------------------------
-- !addquest 7 17
-- Dhea Prandoleh              : !pos 1 -1 15 94
-- Door:Acolyte Hostel (down)  : !pos 124 -3 222 94
-- qm4 (West Sarutabaruta [S]) : !pos 150 -39 331 95
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS)

quest.reward =
{
    item = xi.item.HI_ELIXIR,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.wotg.helpers.hasCompletedFirstQuest(player)
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Dhea_Prandoleh'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(128)
                end,
            },

            onEventFinish =
            {
                [128] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WEST_SARUTABARUTA_S] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SMALL_STARFRUIT) then
                        return quest:keyItem(xi.ki.SMALL_STARFRUIT)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Dhea_Prandoleh'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(160)
                end,
            },

            ['Door_Acolyte_Hostel_down'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SMALL_STARFRUIT) then
                        return quest:progressEvent(129)
                    end
                end,
            },

            onEventFinish =
            {
                [129] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SMALL_STARFRUIT)
                    end
                end,
            },
        },
    },
}

return quest
