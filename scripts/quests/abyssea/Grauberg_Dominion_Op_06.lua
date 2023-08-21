-----------------------------------
-- Grauberg - Dominion Op #06
-----------------------------------
-- !addquest 8 120
-- Dominion Sergeant (Wolfgang's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_06_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_GRAUBERG] =
        {
            ['Glade_Wivre'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 593)
                end,
            },
        },
    },
}

return quest
