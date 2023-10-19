-----------------------------------
-- Uleguerand - Dominion Op #13
-----------------------------------
-- !addquest 8 113
-- Dominion Sergeant (Romaa Mihgo's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_13_ULEGUERAND)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ULEGUERAND] =
        {
            ['Bluffalo'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 586)
                end,
            },
        },
    },
}

return quest
