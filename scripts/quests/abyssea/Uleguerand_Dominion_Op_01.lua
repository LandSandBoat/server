-----------------------------------
-- Uleguerand - Dominion Op #01
-----------------------------------
-- !addquest 8 101
-- Dominion Sergeant (Zazarg's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_01_ULEGUERAND)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ULEGUERAND] =
        {
            ['Mechanical_Menace'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 574)
                end,
            },
        },
    },
}

return quest
