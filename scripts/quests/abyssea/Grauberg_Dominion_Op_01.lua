-----------------------------------
-- Grauberg - Dominion Op #01
-----------------------------------
-- !addquest 8 115
-- Dominion Sergeant (Wolfgang's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_01_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_GRAUBERG] =
        {
            ['Sinister_Seidel'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 588)
                end,
            },
        },
    },
}

return quest
