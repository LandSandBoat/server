-----------------------------------
-- In a Haze of Glory
-----------------------------------
-- !addquest 7 38
-- Rholont       : !pos -168 -2 56 80
-- Diordinne     : !pos -107.785 0 193.665 164
-- Wooden Crates : !pos -0.717 3.347 -99.535 164
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.IN_A_HAZE_OF_GLORY)

quest.reward =
{
    item = xi.item.FULLMETAL_BULLET,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.PERILS_OF_THE_GRIFFON)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] = quest:event(637),
        },

        [xi.zone.GARLAIGE_CITADEL_S] =
        {
            ['Diordinne'] = quest:progressEvent(31),

            onEventFinish =
            {
                [31] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.NUMBER_EIGHT_SHELTER_KEY)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.GARLAIGE_CITADEL_S] =
        {
            ['Diordinne'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.NUMBER_EIGHT_SHELTER_KEY) then
                        if quest:getVar(player, 'Option') == 0 then
                            return quest:event(37)
                        end
                    else
                        local questTimer = quest:getVar(player, 'Timer')

                        if questTimer == 0 then
                            return quest:progressEvent(34)
                        elseif questTimer <= VanadielUniqueDay() then
                            return quest:progressEvent(36)
                        else
                            return quest:event(35):oncePerZone()
                        end
                    end
                end,
            },

            ['Wooden_Crates'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(32)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 2 then
                        return 33
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [33] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [34] = function(player, csid, option, npc)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,

                [36] = function(player, csid, option, npc)
                    quest:setVar(player, 'Timer', 0)
                    npcUtil.giveKeyItem(player, xi.ki.NUMBER_EIGHT_SHELTER_KEY)
                end,

                [37] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.GHOYUS_REVERIE] =
        {
            onEventFinish =
            {
                -- TODO: The assumption for this mission script is to catch Event 1000 which is
                -- sent once the battlefield has been cleared.  This needs to be verified upon
                -- implementation of the instance.
                [10000] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:setPos(2.436, 6.235, -99.966, 127, xi.zone.GARLAIGE_CITADEL_S)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        if VanadielHour() >= 18 then
                            return quest:progressEvent(82)
                        else
                            -- This Event is displayed the first time the condition is met, and
                            -- then changes to 84.  They are the same message in both cases.

                            return quest:event(81)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [82] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        -- NOTE: The Price of Valor also requires specific mission progress; however, it is possible to hit the below
                        -- conditions if this is a second or third nation being completed by the player.

                        xi.quest.setVar(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_PRICE_OF_VALOR, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_PRICE_OF_VALOR)
                    end
                end,
            },
        },
    },
}

return quest
