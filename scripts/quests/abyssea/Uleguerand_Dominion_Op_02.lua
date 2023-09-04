-----------------------------------
-- Uleguerand - Dominion Op #02
-----------------------------------
-- !addquest 8 102
-- Dominion Sergeant (Zazarg's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_02_ULEGUERAND)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ULEGUERAND] =
        {
            ['Spectator'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 575)
                end,
            },
        },
    },
}

return quest
