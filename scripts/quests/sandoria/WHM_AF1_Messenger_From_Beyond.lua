-----------------------------------
-- Messenger from Beyond
-- !addquest: 0 87
-- Narcheral: !pos 128 -11 128 231
-- qm2      : !pos -714 -9 68 103
-----------------------------------
local valkurmID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND)

quest.reward =
{
    item     = xi.item.BLESSED_HAMMER,
    fame     = 20,
    fameArea = xi.fameArea.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainJob() == xi.job.WHM and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Narcheral'] = quest:progressEvent(689),

            onEventFinish =
            {
                [689] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.VALKURM_DUNES] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasItem(xi.item.TAVNAZIA_PASS) and
                        npcUtil.popFromQM(player, npc, valkurmID.mob.MARCHELUTE, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(valkurmID.text.FOUL_PRESENSE)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Narcheral'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.TAVNAZIA_PASS) then
                        return quest:progressEvent(690) -- Finish quest.
                    end
                end,
            },

            onEventFinish =
            {
                [690] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
