-----------------------------------
-- Confessions of a Bellmaker
-- Stone Monument !pos -733 -46 -300 30
-- Reinberta !pos -190 -7 -59 235
-- Mevreauche !pos -193 11 148 231
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
-----------------------------------


local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.CONFESSIONS_OF_A_BELLMAKER)

quest.reward = {
    item = xi.items.MINSTRELS_DAGGER,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.RIVERNE_SITE_A01] = {
            ['Stone_Monument'] = {
                onTrigger = function(player, npc)
                    return quest:progressCutscene(101)
                end,
            },

            onEventFinish = {
                [101] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.keyItem.ORNAMENTED_SCROLL)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.RIVERNE_SITE_A01] = {
            ['Stone_Monument'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressCutscene(102)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return npcUtil.popFromQM(player, GetNPCByID(zones[player:getZoneID()].npc.STONE_MONUMENT), zones[player:getZoneID()].mob.ARCANE_PHANTASM, {hide = 0})
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressCutscene(103)
                    end
                end,
            },

            ['Arcane_Phantasm'] = {
                onMobDeath = function(mob, player, isKiller)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },

            onEventFinish = {
                [102] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
                [103] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:delKeyItem(xi.keyItem.ORNAMENTED_SCROLL)
                end,
            },
        },
        [xi.zone.BASTOK_MARKETS] = {
            ['Reinberta'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(402)
                    end
                end,
            },

            onEventFinish = {
                [402] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
        [xi.zone.NORTHERN_SAN_DORIA] = {
            ['Mevreauche'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(74)
                    end
                end,
            },

            onEventFinish = {
                [74] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },
}

return quest
