-----------------------------------
-- Two Horn the Savage
-----------------------------------
-- Log ID: 6, Quest ID: 17
-----------------------------------
-- !zone 50       = Whitegate
-- Milazahn       = !pos -58.1921 0.000 1.9746
-- Cacaroon       = !pos -71.1544 0.000 -86.0422
-- !zone 65       = Mamook
-- Viscous Liquid = !pos -262.437 5.130 -141.241
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.TWO_HORN_THE_SAVAGE)

quest.reward =
{
    item = xi.item.IMPERIAL_MYTHRIL_PIECE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Milazahn'] = quest:progressEvent(594),

            onEventFinish =
            {
                [594] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Cacaroon'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 1 then
                        return quest:event(608):oncePerZone()
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeHasExactly(trade, { { 'gil', 1000 } })
                    then
                        return quest:progressEvent(595)
                    end
                end,
            },

            ['Milazahn'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(596)
                    end
                end,
            },

            onEventFinish =
            {
                [596] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [595] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.MAMOOK] =
        {
            ['Viscous_Liquid'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if npc:getID() == ID.npc.VISCOUS_LIQUID then
                        if progress == 1 then
                            return quest:progressEvent(212)
                        elseif
                            progress == 2 and
                            npcUtil.popFromQM(player, npc, ID.mob.MAMOOL_JA, { claim = true, hide = 0 })
                        then
                            return quest:messageSpecial(ID.text.IMPENDING_BATTLE)
                        elseif progress == 3 then
                            return quest:progressEvent(213)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [212] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [213] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },

            ['Mamool_Ja'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:setVar(player, 'Prog', 3) -- Zoning will NOT reset progress. Progress is gained and kept as long as the NM has died.
                    end
                end,
            },
        },

    },
}

return quest
