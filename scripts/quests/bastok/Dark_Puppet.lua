-----------------------------------
-- Dark Puppet
-----------------------------------
-- Log ID: 1, Quest ID: 58
-- Cid         : !pos -12 -12 1 237
-- qm4 (Axe)   : !pos -52 27 -85 193
-- qm5 (Sword) : !pos -92 -28 -70 193
-- qm6 (Soul)  : !pos -132 -27 -245 193
-----------------------------------
local ordellesID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET)

quest.reward =
{
    fame     = 40,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.CHAOS_SOLLERETS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY) and
                player:getMainJob() == xi.job.DRK and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] = quest:progressEvent(760),

            onEventFinish =
            {
                [760] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ORDELLES_CAVES] =
        {
            ['qm4'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:hasItem(xi.item.GERWITZS_AXE) and
                        npcUtil.tradeHasExactly(trade, xi.item.DARKSTEEL_INGOT) and
                        npcUtil.popFromQM(player, npc, ordellesID.mob.DARK_PUPPET_OFFSET, { hide = 0 })
                    then
                        player:confirmTrade()

                        return quest:messageSpecial(ordellesID.text.GERWITZS_AXE_DIALOG)
                    end
                end,
            },

            ['qm5'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:hasItem(xi.item.GERWITZS_SWORD) and
                        npcUtil.tradeHasExactly(trade, xi.item.GERWITZS_AXE) and
                        npcUtil.popFromQM(player, npc, ordellesID.mob.DARK_PUPPET_OFFSET + 1, { hide = 0 })
                    then
                        player:confirmTrade()

                        return quest:messageSpecial(ordellesID.text.GERWITZS_SWORD_DIALOG)
                    end
                end,
            },

            ['qm6'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.GERWITZS_SWORD) and
                        npcUtil.popFromQM(player, npc, ordellesID.mob.DARK_PUPPET_OFFSET + 2, { hide = 0 })
                    then
                        player:confirmTrade()

                        return quest:messageSpecial(ordellesID.text.GERWITZS_SOUL_DIALOG)
                    end
                end,
            },

            ['Gerwitzs_Soul'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVar(player, 'Prog', 2)
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 0 then
                        return 10
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 2 then
                        return 122
                    end
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
