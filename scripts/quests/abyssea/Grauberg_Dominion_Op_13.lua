-----------------------------------
-- Grauberg - Dominion Op #13
-----------------------------------
-- !addquest 8 190
-- Dominion Sergeant (Cornelia's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_13_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_GRAUBERG] =
        {
            ['Goblin_Plunderer'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 600)
                end,
            },
        },
    },
}

return quest
