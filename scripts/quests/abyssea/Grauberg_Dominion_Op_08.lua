-----------------------------------
-- Grauberg - Dominion Op #08
-----------------------------------
-- !addquest 8 122
-- Dominion Sergeant (Tosuka-Porika's Camp)
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/abyssea/dominion')
require('scripts/globals/quests')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_08_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_GRAUBERG] =
        {
            ['Deimobugard'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 595)
                end,
            },
        },
    },
}

return quest
