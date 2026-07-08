-----------------------------------
-- Mission Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_mission_adjustments'
local m = Module:new(moduleName)

-- Keep sections in the previous module init order.
if not xi.module.isContentEnabled('ROV') then
    m:addOverride('xi.server.onServerStart', function()
        super()

        -- Rhapsodies of Vana'diel Era
        -- Source: https://forum.square-enix.com/ffxi/threads/51154-Aug.-3-2016-%28JST%29-Version-Update
        ------------------------------------
        --- ToAU Mission 18 "Passing Glory": Adds a forced JST midnight wait to begin Mission 18 (Passing Glory)
        ------------------------------------
        xi.module.modifyInteractionEntry('scripts/missions/toau/17_Guests_of_the_Empire', function(mission)
            local whitegate = mission.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate.onEventFinish[3078] = function(player, csid, option, npc)
                if mission:complete(player) then
                    player:setLocalVar('Mission[4][17]mustZone', 1)
                    player:setCharVar('Mission[4][17]Timer', 1, JstMidnight()) -- Module change: Start JST midnight timer
                end
            end
        end)

        xi.module.modifyInteractionEntry('scripts/missions/toau/18_Passing_Glory', function(mission)
            mission.sections[1].check = function(player, currentMission, missionStatus, vars)
                return currentMission == mission.missionId and
                    not mission:getMustZone(player) and
                    mission:getVar(player, 'Timer') == 0
            end
        end)

        ------------------------------------
        --- ToAU Mission 25 "Playing the Part": Adds a forced JST midnight wait to begin Mission 25 (Playing the Part)
        ------------------------------------
        xi.module.modifyInteractionEntry('scripts/missions/toau/24_Foiled_Ambition', function(mission)
            local whitegate = mission.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate.onEventFinish[3097] = function(player, csid, option, npc)
                if mission:complete(player) then
                    player:setLocalVar('Mission[4][24]mustZone', 1)
                    player:setCharVar('Mission[4][24]Timer', 1, JstMidnight()) -- Module change: Start JST midnight timer
                end
            end
        end)

        xi.module.modifyInteractionEntry('scripts/missions/toau/25_Playing_the_Part', function(mission)
            local whitegate = mission.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate['Naja_Salaheem'].onTrigger = function(player, npc)
                if
                    not mission:getMustZone(player) and
                    mission:getVar(player, 'Timer') == 0 -- Module change: Check JST midnight timer
                then
                    return mission:progressEvent(3110)
                else
                    local dialog = mission:getVar(player, 'Option') + 1 -- Captured values 1 and 2
                    if dialog == 1 then
                        mission:setVar(player, 'Option', 1)
                    else
                        mission:setVar(player, 'Option', 0)
                    end

                    return mission:event(3098, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, dialog, 0)
                end
            end
        end)

        ------------------------------------
        --- ToAU Mission 33 "Sentinels' Honor": Adds a forced JST midnight wait to begin Mission 33 (Sentinels' Honor)
        ------------------------------------
        xi.module.modifyInteractionEntry('scripts/missions/toau/32_In_the_Blood', function(mission)
            local whitegate = mission.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate.onEventFinish[3113] = function(player, csid, option, npc)
                if mission:complete(player) then
                    player:setLocalVar('Mission[4][32]mustZone', 1)
                    player:setCharVar('Mission[4][32]Timer', 1, JstMidnight()) -- Module change: Start JST midnight timer
                end
            end
        end)

        xi.module.modifyInteractionEntry('scripts/missions/toau/33_Sentinels_Honor', function(mission)
            local whitegate = mission.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate['Naja_Salaheem'].onTrigger = function(player, npc)
                local hasZoned      = not mission:getMustZone(player)
                local hasTimePassed = mission:getVar(player, 'Timer') == 0 -- Module change: Check JST midnight timer

                -- Calculate event.
                local eventId = (hasZoned and hasTimePassed) and 3130 or 3120

                -- Calculate dialog.
                local dialog = 2

                if not hasTimePassed then -- Dialog parameter cycles between 0 and 2 until time lockout is over. At that point, option 0 stops happening.
                    dialog = mission:getVar(player, 'Option')
                    if dialog == 0 then
                        mission:setVar(player, 'Option', 2)
                    else
                        mission:setVar(player, 'Option', 0)
                    end
                end

                return mission:event(eventId, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, dialog, 0)
            end
        end)

        ------------------------------------
        --- ToAU Mission 38 "Stirrings of War": Adds a forced JST midnight wait to begin Mission 38 (Stirrings of War)
        ------------------------------------
        xi.module.modifyInteractionEntry('scripts/missions/toau/37_Path_of_Blood', function(mission)
            local whitegate = mission.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate.onEventFinish[3220] = function(player, csid, option, npc)
                if mission:complete(player) then
                    player:setLocalVar('Mission[4][37]mustZone', 1)
                    player:setCharVar('Mission[4][37]Timer', 1, JstMidnight()) -- Module change: Start JST midnight timer
                end
            end
        end)

        xi.module.modifyInteractionEntry('scripts/missions/toau/38_Stirrings_of_War', function(mission)
            mission.sections[1].check = function(player, currentMission, missionStatus, vars)
                return currentMission == mission.missionId and
                    not mission:getMustZone(player) and
                    mission:getVar(player, 'Timer') == 0 -- Module change: Check JST midnight timer
            end
        end)
    end)
end

if not xi.module.isContentEnabled('SOA') then
    m:addOverride('xi.server.onServerStart', function()
        super()

        -- Seekers of Adoulin Era
        -----------------------------------
        -- TOAU Mission 4 "Knight of Gold": Adds a forced JST midnight wait to begin Mission 4 (Knight of Gold)
        -- Source: https://forum.square-enix.com/ffxi/threads/42614-Jun-17-2014-%28JST%29-Version-Update
        -----------------------------------
        xi.module.modifyInteractionEntry('scripts/missions/toau/03_President_Salaheem', function(mission)
            local whitegate = mission.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate['Naja_Salaheem'].onTrigger = function(player, npc)
                if player:getMissionStatus(mission.areaId) == 1 then
                    if
                        not mission:getMustZone(player) and
                        mission:getVar(player, 'Timer') == 0 -- Module change: Check JST midnight timer
                    then
                        return mission:progressEvent(3020, { text_table = 0 }) -- Enter Not-Trion.
                    else
                        return mission:event(3003, { [0] = xi.besieged.getMercenaryRank(player), text_table = 0 }) -- Default Dialog.
                    end
                else
                    return mission:progressEvent(73, { text_table = 0 }) -- Mog Locker scam.
                end
            end

            whitegate.onEventFinish[73] = function(player, csid, option, npc)
                player:setMissionStatus(mission.areaId, 1)
                mission:setMustZone(player)
                mission:setVar(player, 'Timer', 1, JstMidnight()) -- Module change: Start JST midnight timer
            end
        end)

        -----------------------------------
        -- ToAU Mission 6 "Easterly Winds": Adds a forced JST midnight wait to begin Mission 6 (Easterly Winds)
        -- Source: https://forum.square-enix.com/ffxi/threads/44090-Sep-9-2014-%28JST%29-Version-Update
        -----------------------------------
        xi.module.modifyInteractionEntry('scripts/missions/toau/05_Confessions_of_Royalty', function(mission)
            local chateau = mission.sections[1][xi.zone.CHATEAU_DORAGUILLE]

            chateau.onEventFinish[564] = function(player, csid, option, npc)
                if option == 1 then
                    player:delKeyItem(xi.ki.RAILLEFALS_LETTER)
                    if mission:complete(player) then
                        player:setVar('Mission[4][5]Timer', 1, JstMidnight()) -- Module change: Start JST midnight timer
                    end
                end
            end
        end)

        xi.module.modifyInteractionEntry('scripts/missions/toau/06_Easterly_Winds', function(mission)
            local rulude = mission.sections[1][xi.zone.RULUDE_GARDENS]

            rulude.onTriggerAreaEnter[1] = function(player, triggerArea)
                -- Module change: Check JST midnight timer before allowing player to progress the mission
                if mission:getVar(player, 'Timer') == 0 then
                    return mission:progressEvent(10094)
                end
            end
        end)

        -----------------------------------
        -- TOAU Mission 8 "A Mercenary Life": Adds a forced JST midnight wait to begin Mission 8 (A Mercenary Life)
        -- Source: https://forum.square-enix.com/ffxi/threads/42614-Jun-17-2014-%28JST%29-Version-Update
        -----------------------------------
        xi.module.modifyInteractionEntry('scripts/missions/toau/07_Westerly_Winds', function(mission)
            local whitegate = mission.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate.onEventFinish[3028] = function(player, csid, option, npc)
                if mission:complete(player) then
                    player:delKeyItem(xi.ki.RAILLEFALS_NOTE)
                    player:setLocalVar('Mission[4][7]mustZone', 1)
                    player:setCharVar('Mission[4][7]Timer', 1, JstMidnight()) -- Module change: Start JST midnight timer
                end
            end
        end)

        xi.module.modifyInteractionEntry('scripts/missions/toau/08_A_Mercenary_Life', function(mission)
            local whitegate = mission.sections[2][xi.zone.AHT_URHGAN_WHITEGATE]

            whitegate.onTriggerAreaEnter[3] = function(player, triggerArea)
                -- Module change: Check JST midnight timer before allowing player to progress the mission
                if mission:getVar(player, 'Timer') == 0 then
                    return mission:progressEvent(3050, 3, 3, 3, 3, 3, 3, 3, 3, 0)
                end
            end
        end)
    end)
end

-- Return a real module only when a content gate registered overrides.
-- Otherwise return a data-only table to avoid a "No overrides found" loader warning.
if #m.overrides > 0 then
    return m
end

return { name = moduleName }
