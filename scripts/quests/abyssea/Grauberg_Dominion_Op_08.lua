-----------------------------------
-- Grauberg - Dominion Op #08
-----------------------------------
-- !addquest 8 122
-- Dominion Sergeant (Tosuka-Porika's Camp)
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_08_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
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
