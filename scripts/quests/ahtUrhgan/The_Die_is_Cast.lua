-----------------------------------
-- The Die is Cast
-- Random Ring
-----------------------------------
-- Log ID: 6, Quest ID: 16
-- Ratihb: !pos 75.225 -6.000 -137.203 50
-- Ekhu Pesshyadha: !pos -13.043 0.999 103.423 50
-- Jijiroon: !pos 15.913 0.000 -32.676 53
-- qm9: !pos 311.088 -3.674 170.124 54
-----------------------------------

local ID = zones[xi.zone.ARRAPAGO_REEF]
local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_DIE_IS_CAST)

quest.reward =
{
    item  = xi.item.RANDOM_RING,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ratihb'] = quest:progressEvent(591),

            onEventFinish =
            {
                [591] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ekhu_Pesshyadha'] = quest:progressEvent(592),

            onEventFinish =
            {
                [592] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 1
        end,

        [xi.zone.NASHMAU] =
        {
            ['Jijiroon'] = quest:progressEvent(245),

            onEventFinish =
            {
                [245] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 2
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm9'] = quest:progressEvent(212),

            onEventFinish =
            {
                [212] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 3
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm9'] =
            {
                onTrigger = function(player, npc)
                    if npcUtil.popFromQM(player, npc, ID.mob.BUKKI, { hide = 0 }) then
                        return quest:messageSpecial(ID.text.SPINE_CHILL)
                    end
                end,
            },

            ['Bukki'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 4
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm9'] = quest:progressEvent(213),

            onEventFinish =
            {
                [213] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    npcUtil.giveKeyItem(player, xi.ki.BAG_OF_GOLD_PIECES)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 5
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ratihb'] = quest:progressEvent(593),

            onEventFinish =
            {
                [593] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.BAG_OF_GOLD_PIECES)
                    end
                end,
            },
        },
    },
}

return quest
