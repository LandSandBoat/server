-----------------------------------
-- Grauberg - Dominion Op #03
-----------------------------------
-- !addquest 8 117
-- Dominion Sergeant (Wolfgang's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_03_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_GRAUBERG] =
        {
            ['Stygian_Djinn'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 590)
                end,
            },
        },
    },
}

return quest
