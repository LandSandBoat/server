-----------------------------------
-- Grauberg - Dominion Op #05
-----------------------------------
-- !addquest 8 119
-- Dominion Sergeant : !pos -15.513 0.64 -482.04 254
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/abyssea/dominion')
require('scripts/globals/quests')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_05_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_GRAUBERG] =
        {
            ['Putrid_Peapuk'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 592)
                end,
            },
        },
    },
}

return quest
