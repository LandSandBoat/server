-----------------------------------
-- Uleguerand - Dominion Op #03
-----------------------------------
-- !addquest 8 103
-- Dominion Sergeant (Zazarg's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_03_ULEGUERAND)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ULEGUERAND] =
        {
            ['Sub-zero_Gear'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 576)
                end,
            },
        },
    },
}

return quest
