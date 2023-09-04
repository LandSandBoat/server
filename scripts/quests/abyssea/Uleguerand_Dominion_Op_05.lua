-----------------------------------
-- Uleguerand - Dominion Op #05
-----------------------------------
-- !addquest 8 105
-- Dominion Sergeant (Maat's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_05_ULEGUERAND)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ULEGUERAND] =
        {
            ['Verglas_Golem'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 578)
                end,
            },
        },
    },
}

return quest
