-----------------------------------
-- The Rescue
-----------------------------------
-- Log ID: 4, Quest ID: 23
-- Thunder Hawk : !pos -58 -10 6 248
-- Jail Door    : !pos 56 0.1 -23 147
-----------------------------------
local beadeauxID = zones[xi.zone.BEADEAUX]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_RESCUE)

quest.reward =
{
    exp      = 2000,
    gil      = 5000,
    fameArea = xi.fameArea.SELBINA_RABAO,
    keyItem  = xi.ki.MAP_OF_THE_RANGUEMONT_PASS,
    title    = xi.title.HONORARY_CITIZEN_OF_SELBINA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            -- TODO: Fame requirement needs verification
            return status == xi.questStatus.QUEST_AVAILABLE and player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 1
        end,

        [xi.zone.SELBINA] =
        {
            ['Thunder_Hawk'] = quest:progressEvent(80),

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    if option == 70 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SELBINA] =
        {
            ['Thunder_Hawk'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TRADERS_SACK) then
                        return quest:progressEvent(81)
                    else
                        return quest:event(83)
                    end
                end,
            },

            onEventFinish =
            {
                [81] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TRADERS_SACK)
                    end
                end,
            },
        },

        [xi.zone.BEADEAUX] =
        {
            ['_43b'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:hasKeyItem(xi.ki.TRADERS_SACK) and
                        npcUtil.tradeHasExactly(trade, xi.item.QUADAV_CHARM)
                    then
                        return quest:progressEvent(1000)
                    end
                end,

                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.TRADERS_SACK) then
                        return quest:messageSpecial(beadeauxID.text.LOCKED_DOOR_QUADAV_HAS_KEY)
                    end
                end,
            },

            onEventFinish =
            {
                [1000] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.TRADERS_SACK)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SELBINA] =
        {
            ['Thunder_Hawk'] = quest:event(82):replaceDefault(),
        },
    },
}

return quest
