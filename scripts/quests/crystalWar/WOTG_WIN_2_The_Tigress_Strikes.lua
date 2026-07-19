-----------------------------------
-- The Tigress Strikes
-----------------------------------
-- !addquest 7 18
-- Dhea Prandoleh               : !pos 1 -1 15 94
-- Rotih Moalghett              : !pos -64 -75 4 96
-- qm4 (Fort Karugo-Narugo [S]) : !pos 208 -30 54 96
-----------------------------------
local fortKarugoID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES)

quest.reward =
{
    item = xi.item.STAR_GLOBE,
    title = xi.title.AJIDO_MARUJIDOS_MINDER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STIRS)
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Dhea_Prandoleh'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(133)
                end,
            },

            onEventFinish =
            {
                [133] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.FORT_KARUGO_NARUGO_S] =
        {
            ['Rotih_Moalghett'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(101)
                    else
                        return quest:event(104)
                    end
                end,
            },

            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 1 then
                        return quest:progressEvent(102)
                    elseif quest:getVar(player, 'LynxKilled') == 1 then
                        return quest:progressEvent(103)
                    elseif
                        prog == 2 and
                        not GetMobByID(fortKarugoID.mob.TIGRESS_STRIKES_WAR_LYNX):isSpawned()
                    then
                        SpawnMob(fortKarugoID.mob.TIGRESS_STRIKES_WAR_LYNX):updateClaim(player)
                        return quest:noAction()
                    end
                end,
            },

            ['War_Lynx'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mob:getID() == fortKarugoID.mob.TIGRESS_STRIKES_WAR_LYNX then
                        quest:setVar(player, 'LynxKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [102] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [103] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Dhea_Prandoleh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(134)
                    else
                        return quest:event(135)
                    end
                end,
            },

            onEventFinish =
            {
                [134] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:needToZone(true)
                    end
                end,
            },
        },
    },
}

return quest
