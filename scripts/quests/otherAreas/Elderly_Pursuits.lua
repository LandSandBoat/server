-----------------------------------
-- Elderly Pursuits
-----------------------------------
-- Log ID: 4, Quest ID: 75
-- Despachiaire : !pos 108 -40 -83 26
-- Rouva        : !pos -16 2 11 230
-- ???          : !pos -412 0 -362 2
-----------------------------------
-- !addquest 4 75
-----------------------------------
local carpentersLandingID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ELDERLY_PURSUITS)

quest.reward =
{
    item = xi.item.ELEGANT_RIBBON,
}

local function AllParaDead()
    for i = 0, 4 do
        local mob = GetMobByID(carpentersLandingID.mob.PARA_OFFSET + i)
        if not mob:isDead() then
            return false
        end
    end

    return true
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.SECRETS_OF_OVENS_LOST)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(517)
                end,
            },

            onEventFinish =
            {
                [517] = function(player, csid, option, npc)
                    quest:begin(player) -- begin quest
                    npcUtil.giveKeyItem(player, xi.ki.ANTIQUE_AMULET)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(518)
                    end
                end,
            },

            onEventFinish =
            {
                [518] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CATHEDRAL_MEDALLION)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Rouva'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        player:hasKeyItem(xi.ki.ANTIQUE_AMULET)
                    then
                        return quest:progressEvent(747)
                    elseif
                        quest:getVar(player, 'Prog') == 2 and
                        player:hasKeyItem(xi.ki.CATHEDRAL_MEDALLION)
                    then
                        return quest:progressEvent(748)
                    end
                end,
            },

            onEventFinish =
            {
                [747] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [748] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['qm_para'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        if quest:getLocalVar(player, 'ParaKilled') == 1 then
                            player:messageSpecial(carpentersLandingID.text.POLISH, xi.ki.ANTIQUE_AMULET)
                            player:delKeyItem(xi.ki.ANTIQUE_AMULET)
                            quest:setVar(player, 'Prog', 2)
                            quest:setLocalVar(player, 'ParaKilled', 0)
                            return quest:keyItem(xi.ki.CATHEDRAL_MEDALLION)
                        elseif
                            GetNPCByID(carpentersLandingID.npc.QM_PARA):getLocalVar('engaged') < os.time() and
                            GetNPCByID(carpentersLandingID.npc.QM_PARA):getLocalVar('engaged') ~= 1 and
                            npcUtil.popFromQM(player, npc, { carpentersLandingID.mob.PARA_OFFSET }, { claim = true, hide = 0 })
                        then
                            GetNPCByID(carpentersLandingID.npc.QM_PARA):setLocalVar('engaged', 1)
                            GetNPCByID(carpentersLandingID.npc.QM_PARA):setLocalVar('nextMob', carpentersLandingID.mob.PARA_OFFSET + 1)
                            return quest:messageSpecial(carpentersLandingID.text.STENCH_OF_DECAY)
                        end
                    end
                end,
            },

            ['Para'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if AllParaDead() then
                        quest:setLocalVar(player, 'ParaKilled', 1)
                        GetNPCByID(carpentersLandingID.npc.QM_PARA):setLocalVar('nextMob', 0)
                    end
                end,
            },

            onZoneOut =
            {
                function(player, prevZone)
                    quest:setLocalVar(player, 'ParaKilled', 0) -- zoning resets kill progress
                end
            },
        }
    },
}

return quest
