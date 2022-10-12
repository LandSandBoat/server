-----------------------------------
-- The Talekeeper's Gift
-----------------------------------
-- Log ID: 1, Quest ID: 56
-- Deidogg       : !pos -13 7 29 234
-- Detzo         : !pos 5.365 6.999 9.891 234
-- qm_talekeeper : !pos 211 4 -79 127
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local behemothsDominionID = require('scripts/zones/Behemoths_Dominion/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_GIFT)

quest.reward =
{
    fame     = 60,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.FIGHTERS_LORICA,
    title    = xi.title.PARAGON_OF_WARRIOR_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_TRUTH) and
                player:getMainJob() == xi.job.WAR and
                quest:getVar(player, 'Timer') <= VanadielUniqueDay() and
                not quest:getMustZone(player)
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Deidogg'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, xi.items.GINGER_COOKIE)
                    then
                        return quest:progressEvent(172)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(170)
                    end
                end,
            },

            ['Detzo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(171)
                    end
                end,
            },

            onEventFinish =
            {
                [170] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [171] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [172] = function(player, csid, option, npc)
                    player:confirmTrade()

                    quest:begin(player)
                    quest:setVar(player, 'Prog', 0)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BEHEMOTHS_DOMINION] =
        {
            ['qm_talekeeper'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') ~= 7 and
                        not GetMobByID(behemothsDominionID.mob.TALEKEEPERS_GIFT_OFFSET + 0):isSpawned() and
                        not GetMobByID(behemothsDominionID.mob.TALEKEEPERS_GIFT_OFFSET + 1):isSpawned() and
                        not GetMobByID(behemothsDominionID.mob.TALEKEEPERS_GIFT_OFFSET + 2):isSpawned()
                    then
                        SpawnMob(behemothsDominionID.mob.TALEKEEPERS_GIFT_OFFSET + 0):updateClaim(player) -- Picklix_Longindex
                        SpawnMob(behemothsDominionID.mob.TALEKEEPERS_GIFT_OFFSET + 1):updateClaim(player) -- Moxnix_Nightgoggle
                        SpawnMob(behemothsDominionID.mob.TALEKEEPERS_GIFT_OFFSET + 2):updateClaim(player) -- Doglix_Muttsnout

                        return quest:messageSpecial(behemothsDominionID.text.SENSE_OF_FOREBODING)
                    end
                end,
            },

            ['Doglix_Muttsnout'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVarBit(player, 'Prog', 0)
                end,
            },

            ['Moxnix_Nightgoggle'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVarBit(player, 'Prog', 1)
                end,
            },

            ['Picklix_Longindex'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVarBit(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.QUFIM_ISLAND] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.BEHEMOTHS_DOMINION and
                        quest:getVar(player, 'Prog') == 7
                    then
                        return 100
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
