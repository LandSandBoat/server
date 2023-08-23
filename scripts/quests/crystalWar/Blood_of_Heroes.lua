-----------------------------------
-- Blood of Heroes
-----------------------------------
-- !addquest 7 52
-- Animal Spoor      : !pos 543.954 -0.522 -290.313 137
-- Wheel Rut         : !pos 345.162 -0.743 -309.161 137
-- Forbidding Portal : !pos 320 -10.835 158.699 137
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BLOOD_OF_HEROES)

quest.reward =
{
    item  = xi.item.RAM_STAFF,
    title = xi.title.HOUSE_AURCHIAT_RETAINER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SONGBIRDS_IN_A_SNOWSTORM)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] = quest:event(656),
        },

        [xi.zone.XARCABARD_S] =
        {
            ['Animal_Spoor'] = quest:progressEvent(1),

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.XARCABARD_S] =
        {
            ['Animal_Spoor'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(3)
                    elseif
                        questProgress == 3 and
                        not player:hasKeyItem(xi.ki.VIAL_OF_MILITARY_PRISM_POWDER)
                    then
                        -- NOTE: Upon implementation of the instance for this quest, on instance failure will
                        -- need to set the 'Timer' charVar to VanadielUniqueDay() + 1

                        if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                            return quest:progressEvent(13)
                        else
                            return quest:event(15)
                        end
                    end
                end,
            },

            ['Forbidding_Portal'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Instance entry should require questProgress of 3, along with a Vial of Military Prism
                    -- Powder.  Instance is accessed from this NPC with Event 12, param (0, 0, 52)

                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(4)
                    end
                end,
            },

            ['Wheel_Rut'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(2)
                    elseif questProgress == 5 then
                        return quest:progressEvent(7)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 4 then
                        return 6
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [3] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_MILITARY_PRISM_POWDER)
                    quest:setVar(player, 'Prog', 2)
                end,

                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [6] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [7] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setVar(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CHASING_SHADOWS, VanadielUniqueDay() + 1)
                    end
                end,

                [13] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_MILITARY_PRISM_POWDER)
                end,
            },
        },

        [xi.zone.GHOYUS_REVERIE] =
        {
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    -- TODO: The assumption for this mission script is to catch Event 10000 which is
                    -- sent once the battlefield has been cleared.  This needs to be verified upon
                    -- implementation of the instance.

                    quest:setVar(player, 'Prog', 4)
                    player:setPos(319.8, -7.887, 153.741, 65, xi.zone.XARCABARD_S)
                end,
            },
        },
    },
}

return quest
