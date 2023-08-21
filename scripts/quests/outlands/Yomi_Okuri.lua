-----------------------------------
-- Yomi Okuri
-----------------------------------
-- Log ID: 5, Quest ID: 141
-- Jaucribaix      : !pos 91 -7 -8 252
-- Washu           : !pos 49 -6 15 252
-- qm2 (Onzozo)    : !pos -176 10 -60 213
-- qm3 (Valkurm)   : !pos -767 -4 192 103
-----------------------------------
local onzozoID  = zones[xi.zone.LABYRINTH_OF_ONZOZO]
local valkurmID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI)

quest.reward =
{
    fame = 40,
    fameArea = xi.quest.fame_area.NORG,
    item = xi.item.MYOCHIN_SUNE_ATE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA) and
                player:getMainJob() == xi.job.SAM and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL
        end,

        [xi.zone.NORG] =
        {
            ['Jaucribaix'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(quest:getMustZone(player) and 142 or 146)
                end,
            },

            onEventFinish =
            {
                [146] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Jaucribaix'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress <= 3 then
                        return quest:progressEvent(player:hasKeyItem(xi.ki.YOMOTSU_FEATHER) and 152 or 147)
                    elseif questProgress == 4 then
                        return quest:progressEvent(player:needToZone() and 153 or 154)
                    elseif player:hasKeyItem(xi.ki.YOMOTSU_HIRASAKA) then
                        return quest:progressEvent(155)
                    elseif player:hasKeyItem(xi.ki.FADED_YOMOTSU_HIRASAKA) then
                        return quest:progressEvent(156)
                    end
                end,
            },

            ['Washu'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Stage') == 0 and
                        not player:hasKeyItem(xi.ki.WASHUS_TASTY_WURST) and
                        not player:hasKeyItem(xi.ki.YOMOTSU_FEATHER) and
                        npcUtil.tradeHasExactly(trade, { xi.item.HECTEYES_EYE, xi.item.BASTORE_SARDINE, xi.item.SLICE_OF_GIANT_SHEEP_MEAT, xi.item.FROST_TURNIP })
                    then
                        return quest:progressEvent(150)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(148)
                    elseif player:hasKeyItem(xi.ki.WASHUS_TASTY_WURST) then
                        return quest:progressEvent(151)
                    elseif
                        quest:getVar(player, 'Stage') == 0 and
                        not player:hasKeyItem(xi.ki.WASHUS_TASTY_WURST)
                    then
                        return quest:progressEvent(149)
                    end
                end,
            },

            onEventFinish =
            {
                [148] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [150] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.WASHUS_TASTY_WURST)
                    quest:setVar(player, 'Prog', 3)
                end,

                [152] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.YOMOTSU_FEATHER)
                    quest:setVar(player, 'Prog', 4)
                    quest:setMustZone(player)
                end,

                [154] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.YOMOTSU_HIRASAKA)
                    quest:setVar(player, 'Prog', 5)
                end,

                [156] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.FADED_YOMOTSU_HIRASAKA)
                        player:setLocalVar('Quest[5][142]mustZone', 1)
                    end
                end,
            },
        },

        [xi.zone.LABYRINTH_OF_ONZOZO] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.WASHUS_TASTY_WURST) and
                        not GetMobByID(onzozoID.mob.UBUME):isSpawned()
                    then
                        return quest:progressEvent(0)
                    elseif
                        quest:getVar(player, 'Stage') == 1 and
                        not player:hasKeyItem(xi.ki.YOMOTSU_FEATHER)
                    then
                        return quest:progressEvent(1)
                    end
                end,
            },

            ['Ubume'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') <= 3 then
                        quest:setVar(player, 'Stage', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.WASHUS_TASTY_WURST)
                        SpawnMob(onzozoID.mob.UBUME):updateClaim(player)
                    end
                end,

                [1] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.YOMOTSU_FEATHER)
                end,
            },
        },

        [xi.zone.VALKURM_DUNES] =
        {
            ['Doman'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:hasKeyItem(xi.ki.YOMOTSU_HIRASAKA) and
                        (GetMobByID(valkurmID.mob.ONRYO):isDead() or not GetMobByID(valkurmID.mob.ONRYO):isSpawned())
                    then
                        quest:setLocalVar(player, 'valkurmNM', 1)
                    end
                end,
            },

            ['Onryo'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:hasKeyItem(xi.ki.YOMOTSU_HIRASAKA) and
                        (GetMobByID(valkurmID.mob.DOMAN):isDead() or not GetMobByID(valkurmID.mob.DOMAN):isSpawned())
                    then
                        quest:setLocalVar(player, 'valkurmNM', 1)
                    end
                end,
            },

            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    local vanadielHour = VanadielHour()

                    if
                        player:hasKeyItem(xi.ki.YOMOTSU_HIRASAKA) and
                        quest:getLocalVar(player, 'valkurmNM') == 0 and
                        (vanadielHour > 18 or vanadielHour < 5) and
                        not GetMobByID(valkurmID.mob.DOMAN):isSpawned() and
                        not GetMobByID(valkurmID.mob.ONRYO):isSpawned()
                    then
                        npc:setLocalVar('triggerInProgress', 1)
                        return quest:progressEvent(10)
                    elseif quest:getLocalVar(player, 'valkurmNM') == 1 then
                        player:delKeyItem(xi.ki.YOMOTSU_HIRASAKA)
                        return quest:keyItem(xi.ki.FADED_YOMOTSU_HIRASAKA)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    if option == 1 then
                        SpawnMob(valkurmID.mob.DOMAN):updateClaim(player)
                        SpawnMob(valkurmID.mob.ONRYO):updateClaim(player)
                    end
                end,
            },
        },
    },
}

return quest
