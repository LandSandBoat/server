-----------------------------------
-- A Delectable Demon
-----------------------------------
-- !addquest 8 173
-- Cavernous Maw    : !pos 367.980 -0.443 -119.874 103
-- Cirein-croin     : !spawnmob 17662476
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_DELECTABLE_DEMON)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.abyssea.getHeldTraverserStones(player) >= 1 and
                player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.VALKURM_DUNES] =
        {
            ['Cavernous_Maw'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(56)
                end,
            },

            onEventFinish =
            {
                [56] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and player:hasTitle(xi.title.CIREIN_CROIN_HARPOONER)
        end,

        [xi.zone.VALKURM_DUNES] =
        {
            onZoneIn = function(player, prevZone)
                return 57
            end,

            onEventUpdate =
            {
                [57] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(xi.abyssea.getZoneKIReward(player))
                    end
                end,
            },

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.abyssea.getZoneKIReward(player))
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
