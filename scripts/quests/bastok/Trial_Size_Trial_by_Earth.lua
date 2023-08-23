-----------------------------------
-- Trial-Size Trial by Earth
-----------------------------------
-- Log ID: 1, Quest ID: 72
-- Ferrol : !pos 33.708 6.499 -39.425 236
-----------------------------------
local tremorsID = zones[xi.zone.CLOISTER_OF_TREMORS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.SCROLL_OF_INSTANT_WARP,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 20 and
                player:getMainJob() == xi.job.SMN and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 2
        end,

        [xi.zone.PORT_BASTOK] =
        {
            -- NOTE: The below event supports multiple zone references, and which level the Mini Tuning Fork
            -- drops the Avatar fight to.  1 represents Qucksand Caves, and 20 is the level.

            ['Ferrol'] = quest:progressEvent(297, 0, xi.item.MINI_TUNING_FORK_OF_EARTH, 1, 20),

            onEventFinish =
            {
                [297] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        npcUtil.giveItem(player, xi.item.MINI_TUNING_FORK_OF_EARTH)
                    then
                        quest:begin(player)
                    end
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
            ['Ferrol'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMainJob() == xi.job.SMN and
                        trade:hasItemQty(xi.item.MINI_TUNING_FORK_OF_EARTH, 1)
                    then
                        return quest:progressEvent(298, 0, xi.item.MINI_TUNING_FORK_OF_EARTH, 1, 20)
                    end
                end,

                onTrigger = function(player, npc)
                    if not player:hasItem(xi.item.MINI_TUNING_FORK_OF_EARTH) then
                        return quest:progressEvent(301, 0, xi.item.MINI_TUNING_FORK_OF_EARTH, 1, 20)
                    else
                        return quest:event(251)
                    end
                end,
            },

            onEventFinish =
            {
                [298] = function(player, csid, option, npc)
                    if option == 1 then
                        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_TREMORS)
                    end
                end,

                [301] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveItem(player, xi.item.MINI_TUNING_FORK_OF_EARTH)
                    end
                end,
            },
        },

        [xi.zone.CLOISTER_OF_TREMORS] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 578 then
                        if not player:hasSpell(xi.magic.spell.TITAN) then
                            player:addSpell(xi.magic.spell.TITAN)
                            player:messageSpecial(tremorsID.text.TITAN_UNLOCKED, 0, 0, 1)
                        end

                        quest:complete(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Ferrol'] = quest:event(300):replaceDefault(),
        },
    },
}

return quest
