-----------------------------------
-- Love and Ice
-----------------------------------
-- Log ID: 1, Quest ID: 43
-- Carmelo           : !pos -146.476 -7.48 -10.889 236
-- Mirror Pond (J-8) : !pos -96.165 1.518 -392.700 111
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.LAMIA_HARP,
    title    = xi.title.SORROW_DROWNER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:seenKeyItem(xi.ki.CARRIER_PIGEON_LETTER)
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIRENS_TEAR) and
                        player:getFameLevel(xi.quest.fame_area.BASTOK) >= 5
                    then
                        return quest:progressEvent(185)
                    else
                        return quest:event(187)
                    end
                end,
            },

            onEventFinish =
            {
                [185] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CARMELOS_SONG_SHEET)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.CARMELOS_SONG_SHEET) then
                        return quest:progressEvent(186)
                    end
                end,
            },

            onEventFinish =
            {
                [186] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setMustZone(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)
                    end
                end,
            },
        },

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            ['Mirror_Pond_1'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.CARMELOS_SONG_SHEET) then
                        return quest:progressEvent(100)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.CARMELOS_SONG_SHEET)
                end,
            },
        },
    },
}

return quest
