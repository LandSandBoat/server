-----------------------------------
-- The Doorman
-----------------------------------
-- Log ID: 1, Quest ID: 54
-- Phara         : !pos 75 0 -80 234
-- Hide Flap (1) : !pos 293 3 -213 149
-- Naji          : !pos 64 -14 -4 237
-----------------------------------
local davoiID = zones[xi.zone.DAVOI]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.RAZOR_AXE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.WAR and
                player:getMainLvl() >= 40
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Phara'] = quest:progressEvent(151),

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.DAVOI] =
        {
            ['Hide_Flap_1'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SWORD_GRIP_MATERIAL) then
                        if quest:getLocalVar(player, 'nmKilled') == 3 then
                            return quest:keyItem(xi.ki.SWORD_GRIP_MATERIAL)
                        elseif
                            not GetMobByID(davoiID.mob.GAVOTVUT):isSpawned() and
                            not GetMobByID(davoiID.mob.BARAKBOK):isSpawned()
                        then
                            SpawnMob(davoiID.mob.GAVOTVUT):updateClaim(player)
                            SpawnMob(davoiID.mob.BARAKBOK):updateClaim(player)

                            quest:setLocalVar(player, 'nmClaimed', 1)

                            -- TODO: Determine if a specific message is displayed here
                            return quest:noAction()
                        end
                    end
                end,
            },

            ['Barakbok'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getLocalVar(player, 'nmClaimed') == 1 then
                        local nmStatus = quest:getLocalVar(player, 'nmKilled')

                        quest:setLocalVar(player, 'nmKilled', utils.mask.setBit(nmStatus, 0, true))
                    end
                end,
            },

            ['Gavotvut'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getLocalVar(player, 'nmClaimed') == 1 then
                        local nmStatus = quest:getLocalVar(player, 'nmKilled')

                        quest:setLocalVar(player, 'nmKilled', utils.mask.setBit(nmStatus, 1, true))
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Phara'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SWORD_GRIP_MATERIAL) then
                        return quest:progressEvent(152)
                    elseif
                        quest:getVar(player, 'Prog') == 1 and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return quest:progressEvent(153)
                    end
                end,
            },

            onEventFinish =
            {
                [152] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SWORD_GRIP_MATERIAL)

                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    quest:setVar(player, 'Prog', 1)
                end,

                [153] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.YASINS_SWORD)

                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.YASINS_SWORD) then
                        return quest:progressEvent(750)
                    end
                end,
            },

            onEventFinish =
            {
                [750] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.YASINS_SWORD)
                    end
                end,
            },
        },
    },
}

return quest
