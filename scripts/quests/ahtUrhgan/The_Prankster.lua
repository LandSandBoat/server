-----------------------------------
-- The Prankster
-- LogID: 6, QuestID: 60
-- Ahaadah !pos -70 -6 105 50
-- Aht Whitegate region 11
-- Aht Whitegate region 12
-- qm4 !pos 460.166 -14.920 256.214 52
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_PRANKSTER)
local ID = zones[xi.zone.BHAFLAU_THICKETS]

quest.reward =
{
    keyItem = xi.ki.MAP_OF_CAEDARVA_MIRE,
}

quest.sections =
{

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ahaadah'] = quest:progressEvent(1),

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
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
            ['Ahaadah'] = quest:event(15),

            onTriggerAreaEnter =
            {
                [11] = function(player, triggerArea)
                    return quest:progressEvent(2)
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
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

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ahaadah'] = quest:event(16),

            onTriggerAreaEnter =
            {
                [12] = function(player, triggerArea)
                    return quest:progressEvent(3)
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    return quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ahaadah'] = quest:event(17),
        },

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if not GetMobByID(ID.mob.PLAGUE_CHIGOE):isSpawned() then
                        return quest:progressCutscene(1)
                    end
                end,
            },

            ['Plague_Chigoe'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVar(player, 'Prog', 3)
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    npcUtil.popFromQM(player, npc, ID.mob.PLAGUE_CHIGOE, { hide = 0 })
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 3
        end,

        [xi.zone.BHAFLAU_THICKETS] =
        {
            ['Ahaadah'] = quest:event(17),

            ['qm4'] = quest:progressCutscene(2),

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
